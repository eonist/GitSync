import Foundation

extension TreeKind{
    /**
     * The num of items in the entire tree
     * NOTE: This should be cached, only re-calc on alteration
     * IMPORTANT: ⚠️️ This is a exhaustive and naive implementation
     */
    var count:Int{
        return TreeUtils.recursiveFlattened(self).count
    }
    func child(_ at:Int, _ i:Int = 0)->TreeKind?{
        var i:Int = i
        for (e,item) in self.children.enumerated(){
            i += e
            if(at == i){return item}//found item at index
            else{
                if(item.children.count > 0){
                    return item.child(at,i)
                }else{
                    i += 1
                }
            }
            
        }
        return nil
    }
}
