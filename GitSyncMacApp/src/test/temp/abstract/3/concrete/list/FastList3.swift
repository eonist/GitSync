import Foundation
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
    init(_ width: CGFloat, _ height: CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil,_ parent: IElement? = nil, _ id: String? = "", _ dir:Dir = .ver) {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        self.dir = dir
        super.init(width,height,parent,id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    /**
     * Apply new data / align items
     * NOTE: override this to use custom ItemList items
     */
    func reUse(_ listItem:FastListItem){
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
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    override func getClassType() -> String {
        return dir == .ver ? "\(List.self)" : "VList"
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
