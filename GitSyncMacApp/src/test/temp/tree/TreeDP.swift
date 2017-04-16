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
        return nil
    }
    var count:Int{
        return 0
    }
}
