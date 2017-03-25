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
    /**
     * Creates the components in the List Component
     */
    override func resolveSkin() {
        super.resolveSkin()
        mergeAt(dataProvider.items, 0)
    }
    /**
     * Creates and adds items to the _lableContainer
     * TODO: possibly move into ListModifier, TreeList has its mergeAt in an Utils class see how it does it
     */
    func mergeAt(_ dictionaries:[[String:String]], _ index:Int){//TODO: possible rename to something better, placeAt? insertAt?
        var i:Int = index
        for dict:[String:String] in dictionaries {//TODO: use for i
            _ = mergeAt(dict,i)
            i += 1
        }
    }
    func mergeAt(_ dict:[String:String], _ index:Int) -> NSView{
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,object["title"]!, false, lableContainer)
        lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
        item
    }
}
