import Foundation
@testable import Utils

//Continue here: 
    //You can't remove while you walk forward. maybe, make a descendantCount for tree instead would be easier
    //or you could try to find idx after idx || end, and then use the idx to calc how many items needs to be deleted

class HashListModifier {
    /**
     *
     */
    func removeDescendants(_ list:HashList,_ idx:Int){
        var end:Int
        if let idx3dStr = list[idx]{
            var idx3d:[Int] = idx3dStr.array({$0.int})
            idx3d.end = (idx3d.end ?? 0) + 1//incremts the end with 1
            let idxStr:String = idx3d.string
            let subseedingIdx:Int = list[idxStr]!
            if let subseedingItem = list[subseedingIdx]{
                //has subseeding item
            }else{
                //no subseeding item use .count
            }
        }
        
        
        
        
        /*var i:Int = idx2D
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
        }*/
    }
    /**
     *
     */
    func addDecendants(_ list:HashList,_ at:Int){
        
    }
}
