import Foundation
@testable import Utils

/*class PathIdx{
 var idx:[Int]
 init(_ idx:[Int]){
 self.idx = idx
 }
 }*/
class TreeUtils{
    typealias AssertMethod = (_ tree:Tree)->Bool
    static var defaultAssert:AssertMethod = {_ in return true}//returns true as default
    /**
     * Recusivly flattens the the treeStructure into a column structure array of tree items
     */
    static func flattened(_ tree:Tree) -> [Tree] {
        var results:[Tree] = []
        tree.children.forEach { child in
            if(child.children.count > 0) {/*Array*/
                results += TreeUtils.flattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
    /**
     * New
     * Returns an Array of idx3d that passes the PARAM: assert
     */
    static func pathIndecies(_ tree:Tree,_ idx:[Int] = [], _ assert:AssertMethod = defaultAssert) -> [[Int]] {
        let child:Tree = TreeParser.child(tree, idx)!
        return Utils.pathIndecies(child, [], assert)
    }
    /**
     * New
     * TODO: Use the reduce into tuple with arr and dict (See notes for example)
     */
    static func hashList(_ tree:Tree) -> HashList{
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree,[],isOpen)/*flattens 3d to 2d*/
        var arr:[String] = []
        var dict:[String:Int] = [:]
        pathIndecies.forEach{
            let key:String = $0.string
            arr.append(key)
            dict[key] = arr.count-1
        }
        return HashList(arr,dict)
    }
    /**
     * Used to debug Trees
     */
    static func describe(_ tree:Tree,_ key:String, _ level:Int = 0){
        if let props = tree.props, let value:String = props[key]{
            Swift.print(("\t" * level) +  value)
        }
        tree.children.forEach{describe($0, key, level + 1)}
    }
    /**
     * Assert method for Utils.pathIndecies, Other methods also use this method
     */
    static var isOpen:TreeUtils.AssertMethod = { tree in
        guard let props = tree.props, props["isOpen"] == "true" else {
            return false
        }
        return true
    }
}
private class Utils{
    /**
     * Flattens a Tree-Structure to a path Indecies (3d -> 2d)
     * Eureka: Hash Array: You use a Sorted hashArray to solve the 3d->2d sync problem (Research required)
     */
    static func pathIndecies(_ tree:Tree,_ depth:[Int] = [], _ assert:TreeUtils.AssertMethod = TreeUtils.defaultAssert) -> [[Int]] {
        var depth:[Int] = depth + [0]
        var results:[[Int]] = []
        tree.children.forEach{
            results.append(depth)
            //Swift.print("$0.children.count > 0: " + "\($0.children.count > 0)")
            //Swift.print("assert($0): " + "\(assert($0))")
            if($0.children.count > 0 && assert($0)) {/*Array*/
                //Swift.print("dive deeper")
                results += Utils.pathIndecies($0,depth, assert)//dive deeper
            }
            depth.end = depth.end! + 1//increment cur level
        }
        return results
    }
}
