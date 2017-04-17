import Foundation
@testable import Element
@testable import Utils
/**
 * TODO: use DataProvidable don't extend DataProvider
 */
class TreeDP:DataProvider {
    var tree:Tree
    var hashList:HashList
    init(_ tree:Tree){
        self.tree = tree
        self.hashList = TreeUtils.hashList(tree)/*Creates the 2d<->3d idx map*/
        super.init([])
    }
    /**
     * PARAM: at: 2d idx
     */
     override func item(_ at:Int) -> [String:String]?{
        //Swift.print("hashList.arr.count: " + "\(hashList.arr.count)")
        if let idx:String = hashList[at]{/*find the 3d-idx*/
            //Swift.print("idx: " + "\(idx)")
            let treeIdx:[Int] = idx.array({$0.int})/*convert the string "3d-idx" to int array "rd-idx"*/
            if let tree:Tree = self.tree[treeIdx]{/*Find the tree that matches the "3d-idx"*/
                //Swift.print("tree.name: " + "\(tree?.name)")
                return tree.props
            }
        }
        return nil
    }
    override var count:Int{
        return tree.count
    }
    convenience init(_ fileURLStr:String){
        let xml = FileParser.xml(fileURLStr)
        self.init(xml)
     }
    convenience init(_ xml:XML) {
        let tree:Tree = TreeUtils.tree(xml)
        self.init(tree)
    }
}
extension TreeDP{
    //convenience
    
    
}
