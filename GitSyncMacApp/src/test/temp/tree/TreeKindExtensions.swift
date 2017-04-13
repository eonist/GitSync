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
    func child(_ at:Int)->TreeKind{
        var i = 0
        
        
        func child()->TreeKind?{
            for (e,item) in children.enumerated(){
                i += e
                if(at == i){return item}//found item at index
                else{
                    
                }
            }
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
