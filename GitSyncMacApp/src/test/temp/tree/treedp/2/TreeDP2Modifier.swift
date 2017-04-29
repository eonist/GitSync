import Foundation
@testable import Utils

class TreeDP2Modifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp:TreeDP2, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        let count:Int = HashList2Modifier.addDescendants(&dp.hashList, idx2d, dp.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
        dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+count, dp))
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp:TreeDP2, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        let count:Int = HashList2Modifier.removeDescendants(&dp.hashList, idx2d, dp.tree)/*remove items from HashList (via HashListModifier.removeDescendants)*/
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+count, dp))
    }
    /**
     *
     */
    static func open(_ dp:TreeDP2, _ idx3d:[Int]){
        
    }
    static func close(_ dp:TreeDP2, _ idx3d:[Int]){
        
    }
}
