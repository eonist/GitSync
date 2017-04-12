import Foundation
@testable import Utils
@testable import Element

class FastList3:ContainerView3{
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var dataProvider:DataProvider/*data storage*/
    var itemSize:CGSize
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
    override var contentSize:CGSize { get{return dir == .hor ? CGSize(dp.count * itemSize.width ,height) : CGSize(width ,dp.count * itemSize.height) } set{_ = newValue;fatalError("not supported");}}
    init(_ width: CGFloat, _ height: CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil, _ dir:Dir = .ver, _ parent: IElement? = nil, _ id: String? = "") {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        self.dir = dir
        super.init(width,height,parent,id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
