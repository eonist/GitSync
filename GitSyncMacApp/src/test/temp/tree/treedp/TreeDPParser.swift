import Foundation

class TreeDPParser {
    func getProp(_ dp:TreeDP,_ at:Int, _ key:String)-> String{
        
    }
    func getProps(_ dp:TreeDP,_ at:Int, _ key:String)->[String:String]?{
        if let idx:[Int] = dp.hashList[at]{
            return dp.tree.getProps(idx)
        }
        return nil
    }
}
