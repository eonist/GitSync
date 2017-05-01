import Foundation
@testable import Utils
@testable import Element

class TreeList3Parser {
    /**
     *
     */
    static func idx2d(_ treeList:TreeListable3,_ idx3d:[Int])->Int?{
        return treeList.treeDP[idx3d]
    }
    /**
     *
     */
    static func idx3d(_ treeList:TreeListable3,_ idx2d:Int)->[Int]?{
        return treeList.treeDP[idx2d]
    }
    /**
     * NOTE: to get idx2d, you can use treeList.selectedIdx
     */
    static func selected(_ treeList:TreeListable3) -> [Int]?{
        guard let idx2d = treeList.selectedIdx else {
            return nil
        }
        return treeList.treeDP[idx2d]
    }
    
    /**
     *
     */
    static func selected(_ treeList:TreeListable3) -> Tree?{
        let idx3d:[Int] = selected(treeList)
        return 
    }
    //continue here: add item(at:)
        //make extensions as well
}
