import Cocoa
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    var treeDP:TreeDP {return dp as! TreeDP}
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        super.onListItemUpInside(buttonEvent)
        if let idx:Int = selectedIdx{
            let isOpen:Bool = TreeDPParser.getProp(treeDP, idx, "isOpen") == "true"
            Swift.print("isOpen: " + "\(isOpen)")
            if(isOpen){
                TreeDPModifier.close(treeDP, idx)
            }else{
                TreeDPModifier.open(treeDP, idx)
            }
        }
    }
}


//Continue here: 
    //Basically when you add / remove things on the hashList. this should be reflected in the TreeList UI componet
    //also simplify item() in TreeDP
