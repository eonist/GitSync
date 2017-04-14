import Foundation

extension Tree{//maybe treekind isnt needed. Just use Tree?
    /**
     * The num of items in the entire tree
     * NOTE: This should be cached, only re-calc on alteration
     * IMPORTANT: ⚠️️ This is a exhaustive and naive implementation
     */
    var count:Int{
        return TreeUtils.recursiveFlattened(self).count
    }
    /**
     *
     */
    mutating func add(_ child:Tree){
        children.append(child)
    }
    /**
     * NOTE: root isn't considered item 0. Only descendents from root are considered items
     */
    func child(_ at:Int, _ incrementor:(_ i:Int)->Int)->Tree?{
        var i:Int = incrementor()
        for item in self.children{
            if(at == i){return item}//found item at index
            else{
                Swift.print("i: " + "\(i)")
                i += 1
                if(item.children.count > 0){
                    let match:Tree? = item.child(at,i)
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
