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
         func item(_ at:Int)->[String:String]?{
            for (e,item) in items{
                if(at == i)
                if(item is Array){
                    item(at)
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
