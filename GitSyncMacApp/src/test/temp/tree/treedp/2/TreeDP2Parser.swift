import Foundation

class TreeDP2Parser {
    /**
     * Returns
     */
    static func getProp(_ dp:TreeDP2,_ at:Int, _ key:String)-> String?{
        if let props = getProps(dp, at){
            return props[key]
        }
        return nil
    }
    /**
     * Returns properties
     */
    static func getProps(_ dp:TreeDP2,_ at:Int)->[String:String]?{
        if let idx:[Int] = at < dp.hashList.count ? dp.hashList[at] : nil{
            return dp.tree.getProps(idx)
        }
        return nil
    }
    static func values(_ dp:TreeDP2,_ idx:[Int], _ key:String)->[String]{
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(dp.tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        var values:[String] = []
        pathIndecies.forEach{
            let treeIdx:[Int] = $0
            if let tree = dp.tree[treeIdx],let props:[String:String] = tree.props,let value = props[key]{
                values.append(value)
                //Swift.print("$0: " + "\($0)")
            }
        }
        return values
    }
}
