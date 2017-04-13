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
    func child(_ at:Int, _ i:Int = 0)->TreeKind{
        var i:Int = i
        for (e,item) in self.children.enumerated(){
            
            if(at == i){return item}//found item at index
            else{
                if(item.children.count > 0){
                    
                }
            }
            
        }
        /*i += e*/
        func child(_ tree:TreeKind)->TreeKind?{
            
            /*
            for (e,item) in items{
                i += e
                if(at == i){return items[e]}//found a match
                else{//keep looping
                    if(item is Array){//array
                        item(at)
                        else{//item
                            i++
                        }
                    }
                }
            }
            */
            
    }
}
