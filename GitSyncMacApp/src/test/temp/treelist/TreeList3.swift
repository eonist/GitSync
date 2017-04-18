import Cocoa
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    var treeDP:TreeDP {return dp as! TreeDP}
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        super.onListItemUpInside(buttonEvent)
        let viewIndex:Int = contentContainer!.indexOf(buttonEvent.origin as! NSView)
        let isOpen:Bool = TreeDPParser.getProp(treeDP, viewIndex, "isOpen") == "true"
        Swift.print("isOpen: " + "\(isOpen)")
    }
}
