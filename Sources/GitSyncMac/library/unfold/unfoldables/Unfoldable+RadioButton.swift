import Foundation
@testable import Element
@testable import Utils

extension RadioButton{
    var value: Any {
        get {return getSelected()}
        set{if let newValue = newValue as? Bool {setSelected(newValue)}}
    }
}
extension UnFoldable where Self:RadioButton{
    static func unfold(dict:[String:Any]) -> UnFoldable{
        let text:String = UnfoldUtils.value(dict, "text") ?? ""
        let element:ElementConfig = .init(dict)
        let isSelectedStr = UnfoldUtils.value(dict, "isSelected") ?? "false"
        let isSelected:Bool  = isSelectedStr.bool
        return RadioButton.init(text:text, isSelected:isSelected, size:element.size, id:element.id)
    }
}
