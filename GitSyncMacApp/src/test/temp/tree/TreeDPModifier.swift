import Foundation

class TreeDPModifier {
    /**
     *
     */
    static func open(_ dp:TreeDP, _ at:Int){
        dp.tree.setProp([2],("isOpen","true"))//updates tree
        HashListModifier.addDescendants(&dp.hashList, 2, dp.tree)//adds items to HashList (via HashListModifier.addDescendants)
        //send event to FastList UI Component, the times were added
    }
    /**
     *
     */
    static func close(_ dp:TreeDP, _ at:Int){
        dp.tree.setProp([2],("isOpen","false"))//update tree
        HashListModifier.removeDescendants(&dp.hashList, 2, dp.tree)//remove items from HashList (via HashListModifier.removeDescendants)
        //send event to FastList UI component, that items were removed
    }
}
