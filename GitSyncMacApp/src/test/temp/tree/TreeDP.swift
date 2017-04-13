import Foundation
@testable import Element
@testable import Utils

class TreeDP:DataProvidable {
    var items:[Any]?
    init(items:[Any]) {
        self.items = items
    }
}
extension TreeDP{
    func item(_ at:Int) -> [String:String]?{
        //var i = 0
        
        /*
         func item(_ at:Int,_ i:Int)->[String:String]?{
            for (i,item) in items{
                if(item is Array){
                    item(at,i)
                else{
                    i++
                }
            }
         }
        */
        return nil
    }
    var count:Int{
        return 0
    }
}
