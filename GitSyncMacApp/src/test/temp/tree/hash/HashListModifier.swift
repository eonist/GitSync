import Foundation
@testable import Utils

//Continue here: 
    //You can't remove while you walk forward. maybe, make a descendantCount for tree instead would be easier
    //or you could try to find idx after idx || end, and then use the idx to calc how many items needs to be deleted

class HashListModifier {
    /**
     * 
     */
    static func removeDescendants(_ list:inout HashList,_ idx:Int, _ tree:Tree){
        let idx3d:[Int] = list[idx]!
        let child:Tree = tree[idx3d]!
        let count:Int = child.count(TreeUtils.isOpen)
        let end:Int = idx + count
        HashListModifier.remove(&list,idx,end)
    }
    /**
     * Removes
     * TODO: use range as arg, if possible
     */
    static func remove(_ list:inout HashList,_ from:Int, _ to:Int){
        for i in from...to{
            list.remove(i)
        }
    }
    /**
     *
     */
    func addDescendants(_ list:inout HashList,_ idx:Int,_ tree:Tree){
        //you want all open descendants at 3dIdx
        let idx3d:[Int] = list[idx]!
        let child:Tree = TreeParser.child(tree, idx3d)!
    }
}
/*
static func removeDescendants(_ list:inout HashList,_ idx:Int){
    var end:Int
    let idx3dStr = list[idx]
    var idx3d:[Int] = idx3dStr!.array({$0.int})
    idx3d.end = (idx3d.end ?? 0) + 1//incremts the end with 1
    let idxStr:String = idx3d.string
    let subseedingIdx:Int = list[idxStr]!
    if(list[subseedingIdx] != nil){//has subseeding item
        end = subseedingIdx
    }else{//no subseeding item use .count
        end = list.arr.count//<-could be -1
    }
    HashListModifier.remove(&list,idx,end)
}
 */
