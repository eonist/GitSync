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
     * Tree(<items><item/><item/></items>).child(0)//what is returned? continue here: make tests 🏀
     */
    func child(_ at:Int, _ i:Int = 0)->Tree?{
        var i:Int = i
        for item in self.children{
            if(at == i){return item}//found item at index
            else{
                i += 1
                if(item.children.count > 0){
                    return item.child(at,i)
                }
            }
        }
        return nil
    }
}
