import Foundation
@testable import Utils
@testable import Element

class TreList3AdvanceModifier {
    /**
     * NOTE: To explode the entire treeList pass an empty array as PARAM: index
     */
    static func explodeAt(_ treeList:TreeListable3,_ idx3d:[Int]) {
        if let isOpen = treeList.treeDP.tree.props?["isOpen"]  {/*if has isOpen param and its set to false*/
            if isOpen == "true" {//already open
                close(treeList,idx3d)
            }
            //1.traverse all items and set to open
            recursiveApply(&treeList.treeDP.tree[idx3d]!,setValue,("isOpen","true"))
            //2.add all descedants to 2d list
            let idx2d:Int = treeList.treeDP[idx3d]!
            let count:Int = HashList2Modifier.addDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
            //3.use the count to update DP and UI
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+count, treeList.dp))
        }
        let apply:TreeModifier.ApplyMethod = {tree in
            
        }
        TreeModifier.apply(&treeList.treeDP.tree, idx3d, apply)
    }
    /**
     * NOTE: To collapse the entire treeList pass an empty array as PARAM: index
     * NOTE: This method collapses all nodes from the PARAM: index
     */
    static func collapseAt(_ treeList:TreeListable3,_ idx3d:[Int]) {
        //do the same as explode at but set close not open
    }
}
