import Foundation
@testable import Element
@testable import Utils

class TreeDP:DataProvidable {
    var items:[Any]?
    init(items:[Any]) {
        self.items = items
    }
    func item(_ at:Int) -> [String:String]?{
        return nil
    }
    var count:Int{return 0}
}
