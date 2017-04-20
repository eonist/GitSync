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
        Swift.print("⭐ reUse ⭐")
        let idx2d:Int = listItem.idx
        let idx3d:[Int] = treeDP.hashList[idx2d]
        listItem.item.id = idx3d.count.string
        
        let style:IStyle = StyleResolver.style(listItem.item)
        style.describe()
        
        super.reUse(listItem)
        listItem.item.state = SkinStates.over
        ElementModifier.refreshSkin(listItem.item)
        listItem.item.state = SkinStates.none
        ElementModifier.refreshSkin(listItem.item)
    }
}

