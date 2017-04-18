import Cocoa
@testable import Utils
@testable import Element

class FastList3:ContainerView3,FastListable3{
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var dp:DataProvider/*data storage*/
    var itemSize:CGSize
    var dir:Dir
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
    override var contentSize:CGSize {get{return dir == .hor ? CGSize(dp.count * itemSize.width ,height) : CGSize(width ,dp.count * itemSize.height) } set{_ = newValue;fatalError("not supported");}}
    init(_ width:CGFloat, _ height:CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil,_ parent:IElement? = nil, _ id:String? = "", _ dir:Dir = .ver) {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        self.dir = dir
        super.init(width,height,parent,id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        let visibleRange:Range<Int> = visibleItemRange/*visible ItemRange Within View, calcs visibleItems based on lableContainer.y and height*/
        let range:Range<Int> = visibleRange.start..<min(dp.count,visibleRange.end)/*clip the range*/
        renderItems(range)
    }
    /**
     * Apply new data / align items
     * NOTE: override this to use custom ItemList items
     */
    func reUse(_ listItem:FastListItem){
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dp.item(idx)!
        let title:String = dpItem["title"]!
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        if(item.selected != selected){ item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.setTextValue(/*idx.string + " " + */title)
        item.point[dir] = listItem.idx * itemSize[dir]/*position the item*/
    }
    /**
     * CreatesItem
     * NOTE: override this to create custom ListItems
     */
    func createItem(_ index:Int) -> Element{
        //Swift.print("⚠️️ FastList.createItem index: " + "\(index)")
        let item:SelectTextButton = SelectTextButton(itemSize.width, itemSize.height ,"", false, contentContainer)
        contentContainer!.addSubview(item)
        return item
    }
    override func onEvent(_ event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin.superview === contentContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        else if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    override func getClassType() -> String {
        return dir == .ver ? "\(List.self)" : "VList"//<--VList rally? isn't it more like HList atleast?
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        //fatalError("not implemented yet")
        /**/
        let viewIndex:Int = contentContainer!.indexOf(buttonEvent.origin as! NSView)
        List3Modifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        pool.forEach{if($0.item === buttonEvent.origin){selectedIdx = $0.idx}}/*We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies*/
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))/*if selectedIdx is nil then use -1 in the event*///TODO: probably use FastListEvent here in the future
        
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension FastList3{
    /**
     * DP has changed
     * override this method if dp change can affect the super class
     */
    func onDataProviderEvent(_ event:DataProviderEvent){
        Swift.print("FastList.onDataProviderEvent: " + "\(event)")
        Swift.print("event.startIndex: " + "\(event.startIndex)")
        alignContentContainer(event)
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)/*the visible range has changed, render it*/
        }else{
            reUseFromIdx(event.startIndex)/*the visible range hasn't changed, but the data has changed, apply new data*/
        }
    }
}
