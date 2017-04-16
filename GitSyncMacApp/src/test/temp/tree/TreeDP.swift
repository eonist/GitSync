import Foundation
@testable import Element
@testable import Utils
/**
 * TODO: use DataProvidable dont extend DataProvider
 */
class TreeDP:DataProvider {
    var tree:Tree
    var hashList:HashList
    init(_ tree:Tree){
        self.tree = tree
        self.hashList = TreeUtils.hashList(tree)
        super.init([])
    }
    /**
     * PARAM: at:
     */
    override func item(_ at:Int) -> [String:String]?{
        //Swift.print("hashList.arr.count: " + "\(hashList.arr.count)")
        if let idx:String = hashList[at]{
            //Swift.print("idx: " + "\(idx)")
            let treeIdx:[Int] = idx.array({$0.int})
            if let tree:Tree = self.tree[treeIdx]{
                //Swift.print("tree.name: " + "\(tree?.name)")
                return tree.props
            }
        }
        return nil
    }
    override var count:Int{
        return tree.count
    }
    /*convenience init(_ fileURLStr:String){
     let xml = FileParser.xml(fileURLStr)
     self.init(xml)
     }*/
}
extension TreeDP{
    convenience init(_ xml:XML) {
        let tree:Tree = TreeUtils.tree(xml)
        self.init(tree)
    }
    
    
}
