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
        if let idx:[Int] = dp.hashList[at]{
            return dp.tree.getProps(idx)
        }
        return nil
    }
}
