import Foundation

protocol TreeKind {
    //associatedtype Element
    var children:[TreeKind] {get}
    var props:[String:String]? {get}
    var name:String? {get}
    var content:String? {get}//or use Any or T
}
extension TreeKind{
    /**
     * The num of items in the entire tree
     * NOTE: This should be cached, only re-calc on alteration
     * IMPORTANT: ⚠️️ This is a exhaustive and naive implementation
     */
    var count:Int{
        return TreeUtils.recursiveFlattened(self).count
    }
    func child(_ at:Int)->TreeKind{
        
    }
}
class TreeUtils{
    static func recursiveFlattened(_ tree:TreeKind) -> [TreeKind] {
        var results:[TreeKind] = []
        for child in tree.children {
            if(child.children.count > 0) {/*Array*/
                results += TreeUtils.recursiveFlattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
}
