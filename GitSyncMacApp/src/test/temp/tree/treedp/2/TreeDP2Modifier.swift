import Foundation
@testable import Utils

class TreeDP2Modifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp:TreeDP2, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        let count:Int = HashList2Modifier.addDescendants(&dp.hashList, idx2d, idx3d, dp.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
        dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+count, dp))
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp:TreeDP2, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        let count:Int = HashList2Modifier.removeDescendants(&dp.hashList, idx2d, idx3d, dp.tree)/*remove items from HashList (via HashListModifier.removeDescendants)*/
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+count, dp))
    }
    /**
     * New
     */
    static func insert(_ dp:TreeDP2, _ idx3d:[Int],_ tree:Tree){
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            TreeModifier.insert(&dp.tree, idx3d, tree)
            dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+1, dp))/*updates fastlist UI*/
        }
    }
    /**
     * New
     * TODO: create remove for idx2d as well
     */
    static func remove(_ dp:TreeDP2,_ idx3d:[Int]){
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            TreeModifier.remove(&dp.tree, idx3d)
            dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+1, dp))
        }
    }
    /**
     * New
     */
    static func append(_ dp:TreeDP2,_ idx3d:[Int],_ child:Tree){
        if let idx2d:Int = dp[idx3d] {/*makes sure it exists*/
            TreeModifier.append(&dp.tree, idx3d, child)
            dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+1, dp))
        }
    }
}

/*static func open(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }
 static func close(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }*/
