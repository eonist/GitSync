import Foundation
/**
 * TODO: Subscript?
 */
extension Tree{//maybe treekind isnt needed. Just use Tree?
    /**
     * The num of items in the entire tree
     * NOTE: This should be cached, only re-calc on alteration
     * IMPORTANT: ⚠️️ This is a exhaustive and naive implementation
     */
    var count:Int{
        return TreeUtils.flattened(self).count + 1// +1 because it self is not added when recursiveFlattening. only self.children is flattened
    }
    /**
     * Adds a child to children
     */
    mutating func add(_ child:Tree){
        children.append(child)
    }
    func childFlattened(_ at:Int)->Tree?{
        return TreeParser.childFlattened(self, at)
    }
    func child(_ at:[Int])-> Tree?{
        return TreeParser.child(self, at)
    }
    subscript(at:Int) -> Tree? {
        get {
            return self.child(at)
        }
    }
}

/*protocol TreeKind {
 //associatedtype Element
 var children:[TreeKind] {get}
 var props:[String:String]? {get}
 var name:String? {get}
 var content:String? {get}//or use Any or T
 }*/
