import Foundation
@testable import Utils

//Continue here: 
    //You can't remove while you walk forward. maybe, make a descendantCount for tree instead would be easier
    //or you could try to find idx after idx || end, and then use the idx to calc how many items needs to be deleted

class HashListModifier {
    /**
     * 
     */
    static func addDescendants(_ list:inout HashList,_ idx:Int,_ tree:Tree) -> Int{
        let idx3d:[Int] = list[idx]!
        //Swift.print("idx3d: " + "\(idx3d)")
        let child:Tree = TreeParser.child(tree, idx3d)!
        //you want all open descendants at 3dIdx
        var indecies:[[Int]] = TreeUtils.pathIndecies(child,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        indecies = indecies.map{idx3d + $0}//prepend the parent pathIdx to get complete pathIndecies
        Swift.print("idx: " + "\(idx)")
        Swift.print("indecies: " + "\(indecies)")
        list.add(idx+1,indecies)
        return indecies.count
    }
    /**
     * 
     */
    static func removeDescendants(_ list:inout HashList,_ at:Int, _ tree:Tree) -> Int{
        Swift.print("at: " + "\(at)")
        Swift.print("list: " + "\(list)")
        let idx3d:[Int] = list[at]!
        Swift.print("idx3d: " + "\(idx3d)")
        let child:Tree = tree[idx3d]!
        let count:Int = child.count(TreeUtils.isOpen)
        Swift.print("count: " + "\(count)")
        let end:Int = at + count
        HashListModifier.remove(&list,at,end)
        return count
    }
    /**
     * Removes
     * TODO: use range as arg, if possible
     */
    static func remove(_ list:inout HashList,_ from:Int, _ to:Int){
        for i in (from...to).reversed(){//we have to remove backward when dealing with arrays
            Swift.print("i: " + "\(i)")
            list.remove(i)
        }
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
