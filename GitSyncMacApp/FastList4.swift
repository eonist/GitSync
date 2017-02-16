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
        let diff = RangeParser.difference(new, old)//may return 1 or 2 ranges
        
        if(diff.0 != nil){
            inActive += 
        }
        if(diff.1 != nil){
            
        }
        
        /*if(diff != nil){
            let firstOldIdx:Int = pool.first!.idx
            let startIdx:Int = intersection!.start - firstOldIdx
            
            inActive = pool.splice2(0,pool.count)
            //find new to add
            let itemsToAdd = RangeParser.intersection(intersection!, new)
            
        }*/
        
        //Continue here: 
            //find items to remove and add
        
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
