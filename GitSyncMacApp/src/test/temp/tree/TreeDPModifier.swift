import Foundation

class TreeDPModifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp:TreeDP, _ at:Int){
        let idx3d:[Int] = dp.hashList[at]!
        Swift.print("idx3d: " + "\(idx3d)")
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        HashListModifier.addDescendants(&dp.hashList, at, dp.tree)//adds items to HashList (via HashListModifier.addDescendants)
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp:TreeDP, _ at:Int){
        let idx3d:[Int] = dp.hashList[at]!
        Swift.print("idx3d: " + "\(idx3d)")
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        HashListModifier.removeDescendants(&dp.hashList, at, dp.tree)//remove items from HashList (via HashListModifier.removeDescendants)
    }
}
