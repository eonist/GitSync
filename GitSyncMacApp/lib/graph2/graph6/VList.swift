import Foundation
@testable import Element
@testable import Utils

class VList:ContainerView2 {
    var dp:DataProvider
    override var itemSize:CGSize /*{return CGSize(48,48)}*///override this for custom value
    
    init(_ width: CGFloat, _ height: CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil, _ parent: IElement?, _ id: String? = "") {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width,height,parent,id)
        self.dataProvider.event = onEvent/*Add event handler for the dataProvider*/
        //layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
