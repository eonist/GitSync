import Foundation
@testable import Element
@testable import Utils

class TreeDP:DataProvidable {
    var tree:Tree
    var hashList:HashList
    init(_ tree:Tree){
        self.tree = tree
        self.hashList = TreeUtils.hashList(tree)
    }
}
extension TreeDP{
    /**
     * PARAM: at:
     */
    func item(_ at:Int) -> [String:String]?{
        if let idx:String = hashList[at]{
            let treeIdx:[Int] = idx.array({$0.int})
            if let tree:Tree = self.tree[treeIdx]{
                //Swift.print("tree.name: " + "\(tree?.name)")
                return tree.props
            }
        }
        return nil
    }
    var count:Int{
        return tree.count
    }
}
