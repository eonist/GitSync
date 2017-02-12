import Foundation
@testable import Utils
@testable import Element

class FastList3:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var prevVisibleRange:Range<Int>?/*PrevVisibleRange is set on each frame tick and is used to calc how many new items that needs to be rendered/removed*/
    //var visibleItems:[FastListItem] = []//fastlistitem also stores the absolute integer that cooresponds to the db.item
    var pool:[FastListItem] = []
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        //layer!.masksToBounds = true/*masks the children to the frame, I don't think this works...seem to work now*/
    
    }
    var greenRect:RectGraphic?/*green rect that represents the range to render (everything inside this rect must be rendered) (it goes in the itemContainer)*/
    var purpleRect:RectGraphic?/*purple rect that represents the buffer area, 1-item above top and 1-item bellow bottom*/
    
    override func resolveSkin() {
        super.resolveSkin()
        maxVisibleItems = round(height / itemHeight).int//TODO: use floor not round
        lableContainer = addSubView(Container(width,height,self,"lable"))
        
        /*red rect above where the mask is*/
        let redFrame:CGRect = CGRect(1,1,width,height)
        let redRect = RectGraphic(redFrame.x,redFrame.y,redFrame.size.width,redFrame.size.height,nil,LineStyle(1,.red))
        addSubview(redRect.graphic)
        redRect.draw()
        
        /*blue rect above all the items in the itemContainer (use itemsHeight)*/
        let blueFrame:CGRect = CGRect(0,0,width,itemsHeight)
        let blueRect = RectGraphic(blueFrame.x,blueFrame.y,blueFrame.size.width,blueFrame.size.height,nil,LineStyle(1,.blue))
        lableContainer!.addSubview(blueRect.graphic)
        blueRect.draw()
        
        let greenFrame:CGRect = CGRect(0,0,width,height)
        greenRect = RectGraphic(greenFrame.x,greenFrame.y,greenFrame.size.width,greenFrame.size.height,nil,LineStyle(1,.green))
        lableContainer!.addSubview(greenRect!.graphic)
        greenRect!.draw()
        
        let purpleFrame:CGRect = CGRect(0,0,width,height)
        purpleRect = RectGraphic(purpleFrame.x,purpleFrame.y,purpleFrame.size.width,purpleFrame.size.height,nil,LineStyle(1,.purple))
        lableContainer!.addSubview(purpleRect!.graphic)
        purpleRect!.draw()
        
        let numOfItems:Int = Swift.min(maxVisibleItems!+1, dataProvider.count)
        let curVisibleRange:Range<Int> = 0..<numOfItems//<--this should be the same range as we set bellow no?
        prevVisibleRange = -numOfItems..<0//this creates the correct diff later on.
        
        updatePool()//creates a pool of items ready to be used
        reUse(curVisibleRange)
        
    }
    func setProgress(_ progress:CGFloat){
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let curVisibleRange = Utils.curVisibleItems(self, maxVisibleItems!+1)
        /*GreenRect*/
        let top:CGFloat = curVisibleRange.top
        let greenFrame:CGRect = CGRect(0,top,width,maxVisibleItems!*itemHeight)
        greenRect!.setPosition(greenFrame.origin)
        greenRect!.setSizeValue(greenFrame.size)
        greenRect!.draw()
        /*PurpleRect*/
        let purpleFrame:CGRect = CGRect(0,top-itemHeight,width,(maxVisibleItems!*itemHeight)+(itemHeight*2))
        purpleRect!.setPosition(purpleFrame.origin)
        purpleRect!.setSizeValue(purpleFrame.size)
        purpleRect!.draw()
        /**/
        if(curVisibleRange.range != prevVisibleRange){/*Optimization: only set if it's not the same as prev range*/
            reUse(curVisibleRange.range)/*spoof items in the new range*/
            prevVisibleRange = curVisibleRange.range
        }
    }
    
    
    /**
     * NOTE: This method grabs items from pool and append or prepend them
     */
    func reUse(_ cur:Range<Int>){
        Swift.print("reUse: " + "\(cur)")
        let prev = prevVisibleRange!/*we assign the value to a simpler shorter named variable*/
        let diff = prev.start - cur.start
        
        if(abs(diff) >= maxVisibleItems!+1){//spoof every item
            Swift.print("all")
            for i in 0..<pool.count {
                let idx = cur.start + i
                pool[i] = (pool[i].item, idx)
                reUse(pool[i])
            }
        }else if(diff.positive){//cur.start is less than prev.start
            Swift.print("prepend ")
            var bottomItems = pool.splice2(pool.count-diff, diff)//grab items from the bottom
            for i in 0..<bottomItems.count {
                bottomItems[i] = (bottomItems[i].item, cur.start + i);//and move them to the top
                reUse(bottomItems[i])
            }//assign correct absolute idx
            pool = bottomItems + pool/*prepend to list*/
        }else if(diff.negative){//cur.start is more than prev.start
            Swift.print("append")
            var topItems = pool.splice2(0, -1*(diff))//grab items from the top
            for i in 0..<topItems.count {
                topItems[i] = (topItems[i].item, prev.end + i)//and move them to the bottom
                reUse(topItems[i])
            }//assign correct absolute idx
            pool += topItems/*append to list*/
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func reUse(_ listItem:FastListItem){/*override this to use custom ItemList items*/
        Swift.print("spoof: " + "\(listItem.idx)")
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        item.setTextValue(idx.string + " " + title)
        item.y = listItem.idx * itemHeight/*position the item*/
    }
    /**
     * Replensih / drain the pool (aka add / remove items)
     */
    func updatePool(){
        var numOfItems:Int = floor(height / itemHeight).int + 1//TODO: use floor not round
        numOfItems = Swift.min(numOfItems, dataProvider.count)//if a list only has 3 items and the height can fit 5, pool will never need to be bigger than 3 anyway
        if(pool.count == 0){//pool is empty, fill it up
            for _ in 0..<numOfItems{
                let item:FastListItem = (createPoolItem(),0)
                pool.append(item)
                lableContainer!.addSubview(item.item)
            }
        }else if(numOfItems < pool.count){//pool needs more items
            let numOfItemsNeeded = numOfItems - pool.count
            for _ in 0..<numOfItemsNeeded{
                let item:FastListItem = (createPoolItem(),0)
                pool.append(item)
                lableContainer!.addSubview(item.item)
            }
        }else if(numOfItems > pool.count){//pool needs less items
            let numOfItemsUnNeeded = numOfItems - pool.count
            for _ in 0..<numOfItemsUnNeeded{
                let item:FastListItem = (createPoolItem(),0)
                pool.removeLast()
                lableContainer!.addSubview(item.item)
            }
        }else if(numOfItems == pool.count){//pool has just the right amount of items, do nothing
            //do nothing
        }else{
            fatalError("This can't happen: numOfItems: \(numOfItems)  pool.count: \(pool.count)")
        }
    }
    /**
     *
     */
    func createPoolItem()->Element{
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,"", false, lableContainer)
        return item
    }
    /**
     * NOTE: reUses all items from the startIndex of the intersecting range unitl the end of visibleItems.range
     */
    func updateRange(_ range:Range<Int>){
        updatePool()/*Creates enough pool items*/
        let firstPoolIdx:Int = pool.first!.idx
        Swift.print("firstPoolIdx: " + "\(firstPoolIdx)")
        let lastPoolIdx:Int = pool.last!.idx
        Swift.print("lastPoolIdx: " + "\(lastPoolIdx)")
        Swift.print("range.start: " + "\(range.start)")
        
        
        //Continue here: The dp.count is lower after remove action. 🏀
            //figure out how to deal with this scenario
        
        
        if(range.start >= firstPoolIdx && range.start <= lastPoolIdx){//within TODO: use a RangeAsserter method here
            let mergableRange = range.start...lastPoolIdx
            Swift.print("mergableRange: " + "\(mergableRange)")
            for i in mergableRange{/*For loop because the act of adding an item doesn't require shuffling from top to bottoom or bottom to top*/
               // Swift.print("reuse: i: \(i)")
                let item:FastListItem? = ArrayParser.first(pool, i, {$0.idx == $1})
                reUse(item!)
            }
        }
    }
    /**
     * TODO: you need to update the float of the lables after an update
     */
    func onDataProviderEvent(_ event:DataProviderEvent){
        if(event.type == DataProviderEvent.add){/*This is called when a new item is added to the DataProvider instance*/
            let endIdx:Int = event.startIndex + event.items.count
            updateRange(event.startIndex..<endIdx)
        }else if(event.type == DataProviderEvent.remove){
            let endIdx:Int = event.startIndex + event.items.count
            updateRange(event.startIndex..<endIdx)
        }
    }
    override func onEvent(_ event:Event) {
        if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    override func getClassType() -> String {return "\(List.self)"}
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     *
     */
    static func curVisibleItems(_ list:IList,_ maxVisibleItems:Int)->(range:Range<Int>,top:CGFloat){
        let visibleItemsTop:CGFloat = abs(list.lableContainer!.y > 0 ? 0 : list.lableContainer!.y)//NumberParser.minMax(-1*lableContainer!.y, 0, itemHeight * dataProvider.count - height)
        //Swift.print("visibleItemsTop: " + "\(visibleItemsTop)")
        //let visibleBottom:CGFloat = visibleItemsTop + height
        //Swift.print("visibleBottom: " + "\(visibleBottom)")
        //var topItemY:CGFloat {let remainder = visibleItemsTop % itemHeight;return visibleItemsTop-itemHeight+remainder}
        //Swift.print("topItemY: " + "\(topItemY)")
        var topItemIndex:Int = (visibleItemsTop / list.itemHeight).int
        topItemIndex = topItemIndex < 0 ? 0 : topItemIndex
        //topItemIndex = NumberParser.minMax(topItemIndex, 0, dataProvider.count-maxVisibleItems!)//clamp the num between min and max
        //Swift.print("topItemIndex: " + "\(topItemIndex)")
        var bottomItemIndex:Int = topItemIndex + maxVisibleItems
        bottomItemIndex = bottomItemIndex > list.dataProvider.count-1 ? max(list.dataProvider.count-1,0) : bottomItemIndex//the max part forces the value to be no less than 0
        //if(bottomItemIndex >= dataProvider.count){bottomItemIndex = dataProvider.count-1}
        //Swift.print("bottomItemIndex: " + "\(bottomItemIndex)")
        //Swift.print("topItemIndex: " + "\(topItemIndex)")
        let curVisibleRange:Range<Int> = topItemIndex..<bottomItemIndex
        return (curVisibleRange,visibleItemsTop)
    }
    /**
     * When you add/remove items from a list, the list changes size. This method returns a value that lets you keep the same position of the list after a add/remove items change
     * EXAMPLE: let p = progress(100, 500, 0, 700)//(200,0.5)
     */
    static func progress(_ maskHeight:CGFloat,_ newItemsHeight:CGFloat, _ oldLableContainerY:CGFloat, _ oldItemsHeight:CGFloat)->(lableContainerY:CGFloat,progress:CGFloat){
        if(oldLableContainerY >= 0){//this should be more advance, like assert wether an item was inserted in the visiblepart of the view, and position the list accordingly, to be continued
            let progress = SliderParser.progress(oldLableContainerY, maskHeight, oldItemsHeight)
            return (oldLableContainerY,progress)}/*pins the list to the top if its already at the top*/
        let newItemsHeight = newItemsHeight
        let dist = -(newItemsHeight-oldItemsHeight)//dist <-> old and new itemsHeight
        let newProgress = (oldLableContainerY+dist)/(-(newItemsHeight-maskHeight))
        let newLableContainerY = -(newItemsHeight-maskHeight)*newProgress
        return (newLableContainerY,newProgress)
    }
}

//Tests:
    //Continusly and randomly try to add items to the list on repeate, while you scroll up and down

//Ideas:
    //When you remove an item that falls outside the perimeter, then move it to the "pool"
    //if an item is not available in pool and you need it, then create a new one
    //Pool can only have 1 surplus item at the time, you dont want to hold many items that are not in use -> after resize for instance
    //Figure out the pooling in the context that db.count may change while scrolling
        //only move items to buffer when it moves outside top or bottom limit 🚫
        //you insert item before the animation frame tick 👍
    //spoof(range) could use an array.diff method and generate individual spoof(fastlistitem) that way

//Continue here:
    //Add debug rects ✅
    //move fastlist3 and rb....3 to private folder while working on them for faster debugging. ✅
    //Figure out a fast workflow ✅
    

//Question:
    //what happens when an item is inserted into dp?
        //if the item is within visible range, 
            //reUse all items from the index of the inserted item until the end of visibleItems.range (this is not cpu-optimal but its easy, optimize later)
    //what happens when many items are inserted into dp?
        //figure out which items are within visible range
            //reUse all items from the startIndex of the intersecting range unitl the end of visibleItems.range
    //what happens when many items that are not in range are added to dp?
        //a soloution would be to find the min and max idx of the items and then create a range from this. and do the same as item Range
    //what happens when view resizes?
        //updatingPool() -> which may increase/decrease pool.count
        //call reUse with a new range based on -> floor(height/itemHeight) + 1
            
// NOTE: keep in mind that if an item is inserted above visible items, you need to -itemHeight on an offset.y or else the whole list will apear to jump while scrolling, this will leave the list forever offset, but this can be accounted for by storing the offset and using it within calculations 🚫
// NOTE: If you insert above visible area, all you do is -1 on the cur visibleItems range -> which then doesnt result in a diff change and doesnt result in a new spoof. it just keeps on scrolling perfectly in the next frame tick 👌
// NOTE: You might need to create more expressive debug rects to see bugs easier
 

//TODO: Extract the maxVisibleItems variable into two variables, one that is within and one that is buffed with 1 item on top and 1 bellow
//re-implement pool to spoof from
//Figure out how you should calc pool, 
    //think also in the context of resizing list size 
    //and adding/removing items in dp
    //pool should be based on fllor(height/itemHeight) + 1
