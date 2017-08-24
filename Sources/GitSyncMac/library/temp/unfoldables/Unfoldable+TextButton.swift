import Foundation
@testable import Utils
@testable import Element

extension TextButton:UnFoldable{
    enum Key{
        static let text = "text"
    }
}
extension UnFoldable where Self:TextButton{
    static func unfold(dict:[String:Any]) -> UnFoldable {
        let text:String = UnfoldUtils.value(dict, Key.text) ?? ""
        let element:ElementConfig = .init(dict)
        return TextButton.init(text: text, size: element.size, id: element.id)
    }
}
