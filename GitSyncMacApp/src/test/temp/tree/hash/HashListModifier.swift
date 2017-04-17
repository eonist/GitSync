import Foundation
@testable import Utils

//Continue here: 
    //You can't remove while you walk forward. maybe, make a descendantCount for tree instead would be easier

class HashListModifier {
    /**
     *
     */
    func removeDescendants(_ list:HashList,_ idx2D:Int,_ idx3d:[Int]){
        var i:Int = idx2D
        var isDescendant:Bool = true
        while(i<list.arr.count && isDescendant){
            //print(i)
            let idxStr:String = list.arr[i]
            let idx:[Int] = idxStr.array({$0.int})
            let last:Int? = idx[idx3d.count-1]
            if(last != nil && last! == idx.last){
                isDescendant = true
            }
            i+=1
        }
    }
    /**
     *
     */
    func addDecendants(_ list:HashList,_ at:Int){
        
    }
}
