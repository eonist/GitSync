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
        
        var values:[String] = []
        dp.hashList.forEach{
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
