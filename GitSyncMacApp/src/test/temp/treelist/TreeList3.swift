import Cocoa
@testable import Element
@testable import Utils

class TreeList3:ScrollFastList3{
    var treeDP:TreeDP {return dp as! TreeDP}
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        super.onListItemUpInside(buttonEvent)
        if let idx:Int = selectedIdx{
            let isOpen:Bool = TreeDPParser.getProp(treeDP, idx, "isOpen") == "true"
            if(isOpen){
                Swift.print("close 🚫")
                TreeDPModifier.close(treeDP, idx)
            }else{
                Swift.print("open ✅")
                TreeDPModifier.open(treeDP, idx)
            }
        }
    }
}


//Continue here: 
    //Basically when you add / remove things on the hashList. this should be reflected in the TreeList UI componet
    //also simplify item() in TreeDP
