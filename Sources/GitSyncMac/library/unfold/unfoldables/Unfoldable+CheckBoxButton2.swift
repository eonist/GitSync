import Foundation
@testable import Element
@testable import Utils

extension CheckBoxButton2{
    
    enum Key{
        static let checkState = "checkState"
    }
}
extension UnFoldable where Self:CheckBoxButton2{
    var value: Any {
        get {
            Swift.print("CheckBoxButton.getChecked(): \(state.rawValue)")
            return state.rawValue
        }set{
            if let newValue = newValue as? String, let checkedState = CheckedState.init(rawValue: newValue) {
                state = checkedState
            }
        }
    }
    /**
     * UnFolds a CheckBoxButton
     * TODO: ⚠️️ Should probably throw: FaultyKey,FaultyText,FaultyState etc
     */
    static func unfold(dict:[String:Any]) throws -> UnFoldable {
        let text:String = UnfoldUtils.value(dict, Key.text) ?? ""
        let checkedStateStr = UnfoldUtils.value(dict, Key.checkState) ?? "none"
        let checkedState:CheckedState = CheckedState.init(rawValue: checkedStateStr) ?? .none
        let element:ElementConfig = .init(dict)
        return CheckBoxButton2.init(text: text, checkedState: checkedState, size: element.size, id: element.id)
    }
}

