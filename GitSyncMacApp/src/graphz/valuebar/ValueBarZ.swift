import Foundation
@testable import Utils
@testable import Element

class ValueBarZ:Element{
    //var valueLables:[TextArea] = []
    override func resolveSkin() {
        super.resolveSkin()
        //createValueLables()
    }
    override func getClassType() -> String {
        return "ValueBar"
    }
}
