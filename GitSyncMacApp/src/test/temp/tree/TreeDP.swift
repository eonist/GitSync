import Foundation
@testable import Element
@testable import Utils

class TreeDP:DataProvidable {
    var items:[Any]?
    init(items:[Any]) {
        self.items = items
    }
}
//lets try with multidim array first, then maybe upgrade to Tree struct etc?
    //if array count 2 and
extension TreeDP{
    func item(_ at:Int) -> [String:String]?{
        //var i = 0
        
        /*
         func item()->[String:String]?{
         
            for (e,item) in items{
                i += e
                if(at == i){return items[e]}//found a match
                else{//keep looping
                     if(item is Array){//array
                        item(at)
                     else{//item
                        i++
                     }
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
