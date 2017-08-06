import Foundation
@testable import Utils
@testable import Element

class MergeConflictView:Element,UnFoldable{
    
}
extension MergeConflictView{
    var data:[String:Any] {
        get{
            fatalError("not yet")
        }
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
}
