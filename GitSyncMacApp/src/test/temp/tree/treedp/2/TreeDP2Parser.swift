import Foundation
@testable import Utils

class TreeDP2Parser {
    /**
     * Returns
     * EXAMPLE: TreeDP2Parser.getProp(treeDP, idx, "isOpen")
     */
    static func getProp(_ dp:TreeDP2,_ idx2d:Int, _ key:String)-> String?{
        if let props = getProps(dp, idx2d){
            return props[key]
        }
        return nil
    }
    /**
     * Returns properties
     */
    static func getProps(_ dp:TreeDP2,_ idx2d:Int)->[String:String]?{
        let idx3d:[Int] = dp.hashList[idx2d]
        return getProps(dp,idx3d)
    }
    static func getProps(_ dp:TreeDP2,_ idx3d:[Int])->[String:String]?{
        return dp.tree.getProps(idx3d)
    }
    static func values(_ dp:TreeDP2,_ idx:[Int], _ key:String)->[String]{
        var indecies:[[Int]] = TreeUtils.pathIndecies(dp.tree,idx,TreeUtils.isOpen)/*flattens 3d to 2d*/
        indecies = indecies.map{idx + $0}//prepend the parent pathIdx to get complete pathIndecies
        var values:[String] = []
        indecies.forEach{
            if let tree = dp.tree[$0],
                let props:[String:String] = tree.props,
                    let value = props[key]{
                        values.append(value)
                        //Swift.print("$0: " + "\($0)")
            }
        }
        return values
    }
}
