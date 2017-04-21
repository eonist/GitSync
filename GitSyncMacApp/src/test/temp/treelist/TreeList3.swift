import Cocoa
@testable import Element
@testable import Utils

class TreeList3:ScrollFastList3{
    var treeDP:TreeDP2 {return dp as! TreeDP2}
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        super.onListItemUpInside(buttonEvent)
        if let idx:Int = selectedIdx{
            let isOpen:Bool = TreeDP2Parser.getProp(treeDP, idx, "isOpen") == "true"
            if(isOpen){
                Swift.print("close 🚫")
                TreeDP2Modifier.close(treeDP, idx)
            }else{
                Swift.print("open ✅")
                TreeDP2Modifier.open(treeDP, idx)
            }
        }
        if let element = buttonEvent.origin as? IElement{
            Swift.print("Stack: " + "\(ElementParser.stackString(element))")
            //Swift.print("element.id: " + "\(element.id)")
        }
    }
    override func reUse(_ listItem:FastListItem) {
        let idx3d:[Int] = treeDP.hashList[listItem.idx]
        listItem.item.id = idx3d.count.string//the indentation level (from 1 and up)
        listItem.item.setSkinState(listItem.item.getSkinState())
        super.reUse(listItem)
    }
    override func createItem(_ index:Int) -> Element {
        //find the tree item
        let hasChildren:Bool = TreeDP2Asserter.hasChildren(treeDP, index)
        if hasChildren {
            //_ width:CGFloat, _ height:CGFloat,  _ text:String = "defaultText", _ isSelected : Bool = false, _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String = ""
            
            //size.x,size.y,itemData.title,itemData.isOpen,itemData.isSelected,parent
            
            
            return TreeList3Item.init(
        }
        return super.createItem(index)
    }
}

//SelectTextButton(size.x,size.y,itemData.title,itemData.isSelected,parent)
