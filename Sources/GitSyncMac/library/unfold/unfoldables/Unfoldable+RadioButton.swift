import Foundation
@testable import Element
@testable import Utils

extension RadioButton{
    var value: Any {
        get {return getSelected()}
        set{if let newValue = newValue as? Bool {setSelected(newValue)}}
    }
    enum Key{
        static let isSelected = "isSelected"
    }
}
extension UnFoldable where Self:RadioButton{
    static func unfold(dict:[String:Any]) -> UnFoldable{
        let text:String = UnfoldUtils.value(dict, Key.text) ?? ""
        let element:ElementConfig = .init(dict)
        let isSelectedStr = UnfoldUtils.value(dict, Key.isSelected) ?? "false"
        let isSelected:Bool  = isSelectedStr.bool
        return RadioButton.init(text:text, isSelected:isSelected, size:element.size, id:element.id)
    }
}
