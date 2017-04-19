import Foundation
@testable import Element
@testable import Utils
/**
 * TODO: use DataProvidable don't extend DataProvider
 */
class TreeDP2:DataProvider {
    var tree:Tree
    var hashList:[[Int]]
    init(_ tree:Tree){
        self.tree = tree
        self.hashList = TreeUtils.pathIndecies(tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        super.init([])
    }
    /**
     * PARAM: at: 2d idx
     * RETURNS: DataProvider item (aka Dictionary)
     */
    override func item(_ at:Int) -> [String:String]?{
        //Swift.print("hashList.arr.count: " + "\(hashList.arr.count)")
        if let idx:[Int] = at < hashList.count ? hashList[at] : nil{/*find the 3d-idx*/
            //Swift.print("idx: " + "\(idx)")
            let treeIdx:[Int] = idx/*convert the string "3d-idx" to int array "rd-idx"*/
            if let tree:Tree = self.tree[treeIdx]{/*Find the tree that matches the "3d-idx"*/
                //Swift.print("tree.name: " + "\(tree?.name)")
                return tree.props
            }
        }
        return nil
    }
    override var count:Int{
        return hashList.count//return tree.count
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
