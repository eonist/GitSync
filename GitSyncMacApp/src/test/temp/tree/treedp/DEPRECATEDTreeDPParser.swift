import Foundation

class DEPRECATEDTreeDPParser {
    static func getProp(_ dp: DEPRECATEDTreeDP, _ at:Int, _ key:String)-> String?{
        if let props = getProps(dp, at){
            return props[key]
        }
        return nil
    }
    static func getProps(_ dp: DEPRECATEDTreeDP, _ at:Int)->[String:String]?{
        if let idx:[Int] = dp.hashList[at]{
            return dp.tree.getProps(idx)
        }
        return nil
    }
}
