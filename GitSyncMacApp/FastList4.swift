import Cocoa
@testable import Utils
@testable import Element
/**
 * This is a list that can support infinite list items, while still being fast, memory-convervative and responsive. To support 1000's of data items, just use DataProvider, To support millions, consider using a DataProvider that derive its data from a database (SQLite or other)
 * NOTE: Supporting variable item height will require advance caching system for keeping track of item heights.📚 The challenge is to not have to loop through 1000's of items to get the correct .y coordinate (remember setProgress may be called 60 times per second)
 * TODO: test if resize works, by spawning new items etc
 */
class FastList4:Element,IList {
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var pool:[FastListItem] = []
    var inActive:[FastListItem] = []//Stores pool item that are not in-use
    
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        lableContainer = addSubView(Container(width,height,self,"lable"))
        /*calc visibleItems based on lableContainer.y and height*/
        let visibleRange:Range<Int> = visibleItemRange/*visible ItemRange Within View*/
        let range:Range<Int> = visibleRange.start..<min(dp.count,visibleRange.end)/*clip the range*/
        //Swift.print("range: " + "\(range)")
        renderItems(range)
    }
    /**
     * PARAM: progress (0-1)
     * NOTE: setProgress is in this class because RBFastSliderList doesnt extend SliderList, and both classes needs to extend this method
     * NOTE: override this method in SliderFastList and RBSliderFastList
     */
    func setProgress(_ progress:CGFloat){
        //Swift.print("FastList4.setProgress: " + "\(progress)")
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        //Swift.print("range: " + "\(range)")
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)
        }
    }
    /**
     * Apply new data / align items
     * NOTE: override this to use custom ItemList items
     */
    func reUse(_ listItem:FastListItem){
        Swift.print("FastList4.reUse: " + "\(listItem.idx)")
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        if(item.selected != selected){ item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.setTextValue(idx.string + " " + title)
        item.y = listItem.idx * itemHeight/*position the item*/
    }
    /**
     * CreatesItem
     * NOTE: override this to create custom ListItems
     */
    func createItem(_ index:Int) -> Element{
        Swift.print("createItem index: " + "\(index)")
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,"", false, lableContainer)
        lableContainer!.addSubview(item)
        return item
    }
    /**
     * DP has changed
     * override this method if dp change can affect the super class
     */
    func onDataProviderEvent(_ event:DataProviderEvent){
        alignLableContainer(event)
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)/*the visible range has changed, render it*/
        }else{
            reUseFromIdx(event.startIndex)/*the visible range hasn't changed, but the data has changed, apply new data*/
        }
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        //Swift.print("FastList4.onListItemUpInside() ")
        let viewIndex:Int = lableContainer!.indexOf(buttonEvent.origin as! NSView)
        ListModifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        pool.forEach{if($0.item === buttonEvent.origin){selectedIdx = $0.idx}}/*We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies*/
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))/*if selectedIdx is nil then use -1 in the event*///TODO: probably use FastListEvent here in the future
    }
    override func onEvent(_ event:Event) {
        //Swift.print("FastList4.onEvent even.type: \(event.type) event.origin.superview: \(event.origin.superview)" )
        if(event.type == ButtonEvent.upInside && event.origin.superview === lableContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        else if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    override func getClassType() -> String {return "\(List.self)"}
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}

extension FastList4{
    /**
     * Creates, applies data and aligns items defined in PARAM: range
     * TODO: You can optimize the range stuff later when all cases work (it would be possible to creat a custom diff method that is simpler and faster than using generic intersection,diff and exclude)
     * NOTE: this method is inside an extension because it doesn't need to be overriden by super classes
     */
    func renderItems(_ range:Range<Int>){
        //Swift.print("renderItems.range: " + "\(range)")
        
        let old = currentVisibleItemRange
        //Swift.print("old: " + "\(old)")
        let firstOldIdx:Int = old.start
        //Swift.print("firstOldIdx: " + "\(firstOldIdx)")
        /**
         * Figure out which items to remove from pool
         */
        let diff = RangeParser.difference(range, old)//may return 1 or 2 ranges
        //Swift.print("diff: " + "\(diff)")
        if(diff.1 != nil){
            let start = diff.1!.start - firstOldIdx
            inActive += pool.splice2(start, diff.1!.length)
        }
        if(diff.0 != nil){
            let start = diff.0!.start - firstOldIdx
            inActive += pool.splice2(start, diff.0!.length)
        }
        //Swift.print("remove: \(inActive.count)")
        /**
         * Figure out which items to add to pool
         */
        let diff2 = RangeParser.difference(old,range)
        //Swift.print("diff2: " + "\(diff2)")
        if(diff2.1 != nil){
            let startIdx = diff2.1!.start
            let endIdx = diff2.1!.end
            var items:[FastListItem] = []
            for i in (startIdx..<endIdx){
                let item:Element = inActive.count > 0 ? inActive.popLast()!.item : createItem(i)
                let fastListItem:FastListItem = (item:item,idx:i)
                reUse(fastListItem)//applies data and position
                items.append(fastListItem)
            }
            if(items.count > 0){
                var idx:Int = items.first!.idx - firstOldIdx//index in pool
                idx = idx.clip(0, pool.count)
                _ = ArrayModifier.mergeInPlaceAt(&pool, &items, idx)
            }
        }
        //Swift.print("pool.count: " + "\(pool.count)")
        if(diff2.0 != nil){
            let startIdx = diff2.0!.start
            let endIdx = diff2.0!.end
            var items:[FastListItem] = []
            for i in (startIdx..<endIdx){
                let item:Element = inActive.count > 0 ? inActive.popLast()!.item : createItem(i)
                let fastListItem:FastListItem = (item:item,idx:i)
                reUse(fastListItem)//applies data and position
                items.append(fastListItem)
            }
            if(items.count > 0){
                var idx:Int = items.first!.idx - firstOldIdx//index in pool
                idx = idx.clip(0, pool.count)
                _ = ArrayModifier.mergeInPlaceAt(&pool, &items, idx)
            }
        }
        //Swift.print("add: \((diff2.0 != nil ? diff2.0!.length : 0) + (diff2.1 != nil ? diff2.1!.length : 0))")
        //Swift.print("pool.count: " + "\(pool.count)")
        //clear inActive array, if any are left, can happen after resize etc
        //Swift.print("inActive.count: " + "\(inActive.count)")
        /**
         * This could be usefull when size of view changes from big to small etc, or when going from many items to few
         */
        /**/
        //Swift.print("inActive: " + "\(inActive.count)")
    }
    /**
     * Returns the range to render (based on items in DP and how the lableContainer is positioned)
     */
    var visibleItemRange:Range<Int>{
        let firstVisibleItemThatCrossTopOfView = firstVisibleItem
        let lastVisibleItemThatIsWithinBottomOfView = lastVisibleItem
        let visibleItemRange:Range<Int> = firstVisibleItemThatCrossTopOfView..<lastVisibleItemThatIsWithinBottomOfView
        return visibleItemRange
    }
    /**
     * Returns the current visible item range in List
     */
    var currentVisibleItemRange:Range<Int>{
        let firstIdx:Int = pool.count > 0 ? pool.first!.idx : 0
        let lastIdx:Int = pool.count > 0 ? pool.first!.idx + pool.count : 0
        //Swift.print("lastIdx: " + "\(lastIdx)")
        let currentVisibleItemRange:Range<Int> = firstIdx..<lastIdx
        return currentVisibleItemRange
    }
    /**
     * reUses all items from idx, to end idx in pool
     * NOTE: this method is called after dp change: add/remove
     */
    func reUseFromIdx(_ idx:Int){
        if(idx >= firstVisibleItem && idx <= lastVisibleItem){
            let startIdx = idx - firstVisibleItem
            var endIdx = lastVisibleItem - firstVisibleItem
            endIdx = Swift.min(dp.count,endIdx)
            for i in startIdx..<endIdx{/*reUse affected items if item is within visible view*/
                let fastListItem = pool[i]
                reUse(fastListItem)
            }
        }
    }
    func selectAt(_ index:Int){/*convenience*/
        let selectable:ISelectable = list.lableContainer!.subviews[index] as! ISelectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer!)
    }
}

/*
 //call this method after resize etc
 
 inActive.forEach{
    Swift.print("remove inactive")
    $0.item.removeFromSuperview()
 }
 inActive.removeAll()
 
 */
