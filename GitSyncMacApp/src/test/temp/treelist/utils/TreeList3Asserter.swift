import Foundation

class TreeList3Asserter {
    /**
     *
     */
    static func isOpen(_ treeList:TreeListable3, _ idx2d:Int) -> Bool{
        return TreeDP2Parser.getProp(treeList.treeDP, idx2d, "isOpen") == "true"
    }
}
