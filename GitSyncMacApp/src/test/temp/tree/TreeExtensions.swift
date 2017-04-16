import Foundation

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
    
    /**
     * NOTE: root isn't considered item 0. Only descendents from root are considered items
     * PARAM: at: the index of am item as if the tree structure was flattened
     */
    func child(_ at:Int)->Tree?{
        var i:Int = 0
        return Utils.child(self, at, &i)
    }
 
    func child(_ at:[Int])-> Tree?{
        return nil
    }
    
}
private class Utils{
    /**
     * NOTE: this method resides in a Utility method because PARAM: i can't have default value
     */
    static func child(_ child:Tree, _ at:Int, _ i:inout Int)->Tree?{
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
/*protocol TreeKind {
 //associatedtype Element
 var children:[TreeKind] {get}
 var props:[String:String]? {get}
 var name:String? {get}
 var content:String? {get}//or use Any or T
 }*/
