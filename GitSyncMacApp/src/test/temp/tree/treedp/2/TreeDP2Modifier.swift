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
     *
     */
    static func insert(_ treeDP:TreeDP2, _ idx3d:[Int],_ tree:Tree){
        TreeModifier.insert(&treeDP.tree, idx3d, tree)
        //update fastlist UI here?
    }
    /**
     * New
     */
    func remove(_ treeDP:TreeDP2,_ idx3d:[Int]){
        if let idx2d:Int? = treeDP.tree {
            TreeModifier.remove(&treeDP.tree, idx3d)
            treeDP.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+1, self))
        }
        
        //update fastlist UI here?
        
        //Continue here: 🏀
            //we need idx2d
            //super.
    }
    /**
     * New
     */
    func append(_ treeDP:TreeDP2,_ idx3d:[Int],_ child:Tree){
        TreeModifier.append(&treeDP.tree, idx3d, child)
        //update fastlist UI here?
    }
}

/*static func open(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }
 static func close(_ dp:TreeDP2, _ idx3d:[Int]){
 //convert idx3d to idx2d
 }*/
