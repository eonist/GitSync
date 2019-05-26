import Foundation
@testable import Element
@testable import Utils

extension CheckBoxButton:UnFoldable{
    var value: Any {
        get {
            Swift.print("CheckBoxButton.getChecked(): \(getChecked())")
            return getChecked()
        }set{
            if let newValue = newValue as? Bool {setChecked(newValue)}
        }
    }
    enum Key{
        static let text = "text"
        static let isChecked = "isChecked"
    }
}
extension UnFoldable where Self:CheckBoxButton{
    /**
     * UnFolds a CheckBoxButton
     */
    static func unfold(dict: [String : Any]) throws -> UnFoldable {
        let text:String = UnfoldUtils.value(dict, Key.text) ?? ""
        let isCheckedStr = UnfoldUtils.value(dict, Key.isChecked) ?? "false"
        let isChecked:Bool = isCheckedStr.bool
        let element:ElementConfig = .init(dict)
        return CheckBoxButton.init(text:text,isChecked:isChecked,size:element.size,id:element.id)
    }
}
