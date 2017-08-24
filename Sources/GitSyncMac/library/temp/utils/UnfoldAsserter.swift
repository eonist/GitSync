import Foundation
@testable import Utils
@testable import Element

class UnfoldAsserter{
    static func isMatch(_ unfoldable:UnFoldable, _ id:String) -> Bool{
        if let element = unfoldable as? ElementKind, element.id == id {/*found a match*/
            return true
        }else{/*no match*/
            return false
        }
    }
}
