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
}
