import Foundation
@testable import Utils

class TreeList3Modifier {
    /**
     * Sets a selectable in PARAM: treeList at PARAM: index (array index)
     * NOTE: this does not unselect previously selected items.
     */
    static func select(_ treeList:TreeListable3, _ idx3d:[Int],_ isSelected:Bool = true) {
        if let idx2d:Int = TreeList3Parser.idx2d(treeList, idx3d){//get idx2d
            FastList3Modifier.select(treeList, idx2d, isSelected)
        }
    }
    /**
     *
     */
    static func open(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDP2Modifier.open(treeList.treeDP, idx2d)
        }
    }
    /**
     *
     */
    static func close(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDP2Modifier.close(treeList.treeDP, idx2d)
        }
    }
    /**
     * NOTE: To explode the entire treeList pass an empty array as PARAM: index
     */
    static func explodeAt(_ treeList:TreeListable3,_ idx3d:[Int]) {
        if let isOpen = treeList.treeDP.tree.props?["isOpen"]  {/*if has isOpen param and its set to false*/
            if isOpen == "true" {//already open
                close(treeList,idx3d)
            }
         
            //traverse all items and set to open
            recursiveApply(&treeList.treeDP.tree[idx3d]!,setValue,("isOpen","true"))
            //add all descedants to 2d list
            let idx2d:Int = treeList.treeDP[idx3d]!
            let count:Int = HashList2Modifier.addDescendants(&treeList.treeDP.hashList, idx2d, idx3d, treeList.treeDP.tree)/*adds items to HashList (via HashListModifier.addDescendants)*/
            //use the count to update DP and UI
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
        
    }
    
    typealias KeyValue = (key:String,val:String)
    typealias Apply = (_ tree:inout Tree, _ prop:KeyValue) -> Void
    
    static var setValue:Apply = {tree,prop in
        tree.props?[prop.key] = prop.val
    }
    /**
     * EXAMPLE: recursiveApply(tree[idx3d],setValue,("isOpen","true"))
     * NOTE: This method traverses down hierarchy
     */
    static func recursiveApply(_ tree:inout Tree, _ apply:@escaping Apply, _ prop:KeyValue){
        apply(&tree,prop)
        for i in tree.children.indices {
            recursiveApply(&tree.children[i],apply,prop)
        }
    }
  
    
}
