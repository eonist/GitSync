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
     * NOTE:: this function works as long as multiple selection is not allowed in the treeList
     */
    static func unSelectAll(_ treeList:TreeListable3){
        if let idx3d:[Int] = TreeList3Parser.selected(treeList) {
            select(treeList, idx3d, false)
        }
    }
    /**
     * Open a PARAM: treeList at PARAM: idx3d
     */
    static func open(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDP2Modifier.open(treeList.treeDP, idx2d)
        }
    }
    /**
     * Close a PARAM: treeList at PARAM: idx3d
     */
    static func close(_ treeList:TreeListable3, _ idx3d:[Int]){
        if let idx2d:Int = treeList.treeDP[idx3d]{
            TreeDP2Modifier.close(treeList.treeDP, idx2d)
        }
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
