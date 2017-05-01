import Foundation

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
     *
     */
    static func selected(_ treeList:TreeListable3){
        if let selectedIdx2d = treeList.selectedIdx{
            
        }
    }
}
