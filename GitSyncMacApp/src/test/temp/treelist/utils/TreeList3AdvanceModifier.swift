import Foundation
@testable import Utils
@testable import Element

class TreeList3AdvanceModifier {
    /**
     * NOTE: To explode the entire treeList pass an empty array as PARAM: index
     */
    static func explode(_ treeList:TreeListable3,_ idx3d:[Int]) {
        if let isOpen = treeList.treeDP.tree.props?["isOpen"]  {/*if has isOpen param and its set to false*/
            if isOpen == "true" {/*already open*/
                TreeList3Modifier.close(treeList,idx3d)//also updates DP
            }
            /*1.traverse all items and set to open*/
            TreeList3Modifier.recursiveApply(&treeList.treeDP.tree[idx3d]!,TreeList3Modifier.setValue,("isOpen","true"))
            /*2.add all descedants to 2d list*/
            let idx2d:Int = treeList.treeDP[idx3d]!
            let count:Int = HashList2Modifier.addDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
            /*3.use the count to update DP and UI*/
            treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+count, treeList.dp))
        }
    }
    /**
     * Collapses descendants (if you want to close the item at idx3d as well, then use the folow this call by a close call)
     * TODO: Consider adding flag to close it self as well
     * NOTE: This method collapses all nodes from the PARAM: index
     * NOTE: A goal here is to call onEvent only once
     * NOTE: To collapse the entire treeList pass an empty array as PARAM: index
     * NOTE: You can collapse the entire list and follow it with an open call. this repoens root again
     */
    static func collapse(_ treeList:TreeListable3,_ idx3d:[Int]) {
        Swift.print("collapse")
        if let child:Tree = treeList.treeDP.tree[idx3d] {
            Swift.print("child.props: " + "\(child.props)")
            if let isOpen = child.props?["isOpen"] {/*if has isOpen param and it's set to false*/
                Swift.print("isOpen: " + "\(isOpen)")
                if isOpen == "true" {/*item at idx3d was open*/
                    Swift.print("child.children.count: " + "\(child.children.count)")
                    /*1.Remove all descendants to 2d list*/
                    Swift.print("1.remove all descedants to 2d list")
                    var range:Range<Int>
                    if let idx2d = treeList.treeDP[idx3d] {
                        Swift.print("idx2d: " + "\(idx2d)")
                        /*removes items from HashList*/
                        let count:Int = HashList2Modifier.removeDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)
                        /*2.Traverse all items and set to close*/
                        range = idx2d..<(idx2d+count)
                        Swift.print("2.traverse all items and set to close")
                    }else{//basically if idx3d is [] (aka root)
                        range = 0..<treeList.treeDP.count
                        treeList.treeDP.hashList = []//remove the entire 2d list
                    }
                    //recursive apply to tree:
                    TreeList3Modifier.recursiveApply(&treeList.treeDP.tree[idx3d]!,TreeList3Modifier.setValue,("isOpen","false"))
                    /*3.Use the count to update DP and UI*/
                    Swift.print("3.use the count to update DP and UI")
                    treeList.dp.onEvent(DataProviderEvent(DataProviderEvent.remove,range.start,range.end,treeList.dp))
                }
            }
        }
    }
    /**
     * TODO: Should explode each node until it reaches its idx3d
     * NOTE: when to use this? When you programatically want to reveal an item deeply nested in the tree-structure
     * TODO: acompany this method with a scrollTo(idx3d) method
     */
    static func reveal(){
        
    }
}
