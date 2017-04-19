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
    }
}


//Continue here: 
    //Basically when you add / remove things on the hashList. this should be reflected in the TreeList UI componet
    //also simplify item() in TreeDP
