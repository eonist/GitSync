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
        listItem.item.id = idx3d.count.string/*the indentation level (from 1 and up)*/
        listItem.item.setSkinState(listItem.item.getSkinState())
        //
        if let checkable = listItem.item as? ICheckable{
            let isChecked = TreeDP2Parser.getProp(treeDP, idx, "isOpen") == "true"
            checkable.setChecked(isChecked)/*Sets correct open/close icon*/
        }
        super.reUse(listItem)/*sets text and position and select state*/
    }
    override func createItem(_ index:Int) -> Element {
        let hasChildren:Bool = TreeDP2Asserter.hasChildren(treeDP, index)
        return hasChildren ? Utils.createTreeListItem(itemSize,contentContainer!) : super.createItem(index)/*Create SelectTextButton*/
    }
    override func getClassType() -> String {
        return "\(TreeList3.self)"
    }
}
private class Utils{
    /*create TreeItem*/
    static func createTreeListItem(_ itemSize:CGSize, _ parent:Element) -> TreeList3Item{
        let item:TreeList3Item = TreeList3Item(itemSize.width, itemSize.height ,"", false, false, parent)
        parent.addSubview(item)
        return item
    }
}
