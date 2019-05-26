import Foundation
@testable import Utils
@testable import Element

/**
 * NOTE: Key: stores keys to access getters and setters,should be moved to the individuel UI extensions
 * NOTE: Config: structs are nice if you want to sub-class Components, then they can be re-used, avoids duplicate code
 * NOTE: We use static func unfold instead of .init. As .init would clutter up Element.init. always favour KISS
 */
extension TextInput:UnFoldable{
    enum Key{
        static let text = "text"
        static let inputText = "inputText"
    }
    var value:Any {
        get{return self.inputText}
        set{if let newValue:String = newValue as? String { self.setInputText(newValue) }}
    }
}
extension UnFoldable where Self:TextInput{/*<-Attaches the Unfoldable protocol to TextInput*/
    static func unfold(dict:[String:Any]) throws -> UnFoldable{
        let elementConfig:ElementConfig = .init(dict)
        let text:String = UnfoldUtils.value(dict, Key.text) ?? ""
        let inputText:String = UnfoldUtils.value(dict, Key.inputText) ?? ""
        return TextInput.init(text: text, inputText: inputText, size: elementConfig.size, id: elementConfig.id)
    }
}
