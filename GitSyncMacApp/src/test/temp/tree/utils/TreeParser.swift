import Foundation
@testable import Utils

class TreeParser {
    /**
     * Returns an an TREE instance at PARAM: index (pathIdx)
     * NOTE: this function is recursive
     * NOTE: to find the children of the root use an empty array as the index value
     */
    static func child(_ tree:Tree?,_ index:[Int])-> Tree?{
        if(index.count == 0 && tree != nil) {
            return tree
        }else if(index.count == 1 && tree != nil && tree!.child(index.first!) != nil) {//XMLParser.childAt(xml!.children!, index[0])
            return tree!.child(index[0])
        }// :TODO: if index.length is 1 you can just ref index
        else if(index.count > 1 && tree!.children.count > 0) {
            return TreeParser.child(tree!.child(index.first!), index.slice2(1,index.count))
        }
        return nil
    }
    /**
     * NOTE: root isn't considered item 0. Only descendents from root are considered items
     * PARAM: at: the index of am item as if the tree structure was flattened
     */
    static func childFlattened(_ tree:Tree, _ at:Int)->Tree?{
        var i:Int = 0
        return Utils.childFlattened(tree, at, &i)
    }
}
private class Utils{
    /**
     * NOTE: this method resides in a Utility method because PARAM: i can't have default value
     */
    static func childFlattened(_ child:Tree, _ at:Int, _ i:inout Int)->Tree?{
        for item in child.children{
            if(at == i){return item}//found item at index
            else{
                //Swift.print("i: " + "\(i)")
                i += 1
                if(item.children.count > 0){
                    let match:Tree? = Utils.child(item,at,&i)
                    if(match != nil){return match}
                }
            }
        }
        return nil
    }
}
