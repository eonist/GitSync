import Foundation
@testable import Utils
@testable import Element

class FastList4:Element,IList {
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var pool:[FastListItem] = []
    
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        
    }
    override func resolveSkin() {
        super.resolveSkin()
        //Continue here: 
            //calc visibleItems based on lableContainer.y and height
        let numOfItemsThatCanFitHeight:Int = numOfItemsThatCanFit
        _ = numOfItemsThatCanFitHeight
        
        let visibleItemRangeWithinView:Range<Int> = visibleItemRange
        _ = visibleItemRangeWithinView
        
        lableContainer = addSubView(Container(width,height,self,"lable"))
    }
    /**
     *
     */
    func renderItems(_ range:Range<Int>){
        
        var inActive:[FastListItem] = []
        /**/
        let old = currentVisibleItemRange
        let new = visibleItemRange
        let firstOldIdx:Int = pool.first!.idx
        /*figure out which items to remove from pool*/
        let diff = RangeParser.difference(new, old)//may return 1 or 2 ranges
        if(diff.1 != nil){
            let start = diff.1!.start - firstOldIdx
            inActive += pool.splice2(start, diff.1!.length)
        }
        if(diff.0 != nil){
            let start = diff.0!.start - firstOldIdx
            inActive += pool.splice2(start, diff.0!.length)
        }
        /*figure out which items to add to pool*/
        let diff2 = RangeParser.difference(old,new)
        if(diff2.1 != nil){
            let startIdx = diff2.1!.start
            let endIdx = diff2.1!.end
            var items:[FastListItem] = []
            for i in (startIdx...endIdx){
                let item:Element = inActive.count > 0 ? inActive.popLast()!.item : createItem(i)
                let fastListItem:FastListItem = (item:item,idx:i)
                reUse(fastListItem)//applies data and position
                items.append(fastListItem)
            }
            let idx:Int = items.first!.idx - firstOldIdx//index in pool
            _ = ArrayModifier.mergeInPlaceAt(&pool, &items, idx)
        }
    }
    /**
     *
     */
    func reUse(_ listItem:FastListItem){/*override this to use custom ItemList items*/
        Swift.print("reUse: " + "\(listItem.idx)")
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        item.setTextValue(idx.string + " " + title)
        item.y = listItem.idx * itemHeight/*position the item*/
    }
    /**
     *
     */
    func createItem(_ index:Int) -> Element{
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,"", false, lableContainer)
        return item
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension FastList4{
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
        let lastIdx:Int = pool.count > 0 ? pool.last!.idx : 0
        let currentVisibleItemRange:Range<Int> = firstIdx..<lastIdx
        return currentVisibleItemRange
    }
}
