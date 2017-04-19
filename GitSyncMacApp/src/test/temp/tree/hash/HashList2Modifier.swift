import Foundation
@testable import Utils

class HashList2Modifier {
    /**
     * Inserts descendants into the 2d list
     */
    static func addDescendants(_ list:inout [[Int]],_ idx:Int,_ tree:Tree) -> Int{
        let idx3d:[Int] = list[idx]
        //Swift.print("idx3d: " + "\(idx3d)")
        let child:Tree = TreeParser.child(tree, idx3d)!
        //you want all open descendants at 3dIdx
        var indecies:[[Int]] = TreeUtils.pathIndecies(child,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        indecies = indecies.map{idx3d + $0}//prepend the parent pathIdx to get complete pathIndecies
        Swift.print("idx: " + "\(idx)")
        Swift.print("indecies: " + "\(indecies)")
        let indexAfter:Int = idx+1
        list.insert(contentsOf: indecies, at: indexAfter)
        return indecies.count
    }
    /**
     * Remove descendants into the 2d list
     */
    static func removeDescendants(_ list:inout [[Int]],_ at:Int, _ tree:Tree) -> Int{
        Swift.print("at: " + "\(at)")
        Swift.print("list: " + "\(list)")
        let idx3d:[Int] = list[at]
        Swift.print("idx3d: " + "\(idx3d)")
        let child:Tree = tree[idx3d]!
        let count:Int = child.count(TreeUtils.isOpen)
        Swift.print("count: " + "\(count)")
        let end:Int = at + count
        _ = ArrayModifier.removeRange(&list, at,end)
        return count
    }
}
