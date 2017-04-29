import Foundation

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
    static func open(_ treeList:TreeList3, _ at:[Int]){
        
    }
    /**
     *
     */
    static func close(_ treeList:TreeList3, _ at:[Int]){
        
    }
    /**
     * NOTE: To explode the entire treeList pass an empty array as PARAM: index
     */
    static func explodeAt(_ treeList:TreeListable3,_ idx3d:[Int]) {
        
    }
    /**
     * NOTE: To collapse the entire treeList pass an empty array as PARAM: index
     * NOTE: This method collapses all nodes from the PARAM: index
     */
    static func collapseAt(_ treeList:TreeListable3,_ idx3d:[Int]) {
        
    }
}
