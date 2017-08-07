import Foundation
@testable import Utils
@testable import Element

enum Unfold{
    enum TextInput{
        static let inputText = "inputText"
        static let text = "text"
    }
    enum Text{
        static let text = "text"
    }
}

extension TextInput:UnFoldable{/*<-Attaches the Unfoldable protocol to TextInput*/
    typealias TextInputConfig = (text:String, inputText:String)
    /**
     * Unfolds a TextInput component
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> TextInput{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, Unfold.TextInput.text) ?? ""
        let inputText:String = UnFoldUtils.string(dict, Unfold.TextInput.inputText) ?? ""
        let config:TextInputConfig = (text:text,inputText:inputText)
        let textInput:TextInput = TextInput.init(elementConfig, config)
        return textInput
    }
    convenience init(_ element:ElementConfig, _ config:TextInputConfig) {
        self.init(element.width, element.height, config.text, config.inputText, element.parent, element.id)
    }
    var data:[String:Any] {
        get{
            //fatalError("not avilabale")
            return [Unfold.TextInput.text:self.text.getText(),Unfold.TextInput.inputText:self.inputTextArea.text.getText()]
        }set{
            if let text:String = newValue[Unfold.TextInput.text] as? String { self.text.setText(text) }
            if let inputText:String = newValue[Unfold.TextInput.inputText] as? String { self.inputTextArea.setTextValue(inputText) }
        }
    }
}
extension CheckBoxButton{
    struct CheckBoxButtonConfig{
        let text:String
        let isChecked:Bool
        let elementConfig:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            elementConfig = Element.elementConfig(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
            let isCheckedStr = UnFoldUtils.string(dict, "isChecked") ?? "false"
            isChecked = isCheckedStr.bool
        }
    }
    /**
     * UnFolds a CheckBoxButton
     */
    static func unFold(_ dict:[String:Any],_ parent:ElementKind? = nil) -> CheckBoxButton{
        let config:CheckBoxButtonConfig = .init(dict,parent)
        return CheckBoxButton.init(config)
    }
    convenience init(_ config:CheckBoxButtonConfig) {
        self.init(config.elementConfig.width, config.elementConfig.height,config.text,config.isChecked, config.elementConfig.parent, config.elementConfig.id)
    }
}
extension TextButton{
    typealias TextButtonConfig = (String)
    /**
     * UnFolds a TextButton Component
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> TextButton{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
//        Swift.print("text: " + "\(text)")
//        Swift.print("dict: " + "\(dict)")
        let config:TextButtonConfig = (text)
        return TextButton.init(elementConfig, config)
    }
    convenience init(_ element:ElementConfig, _ config:TextButtonConfig) {
        self.init(element.width, element.height,config, element.parent, element.id)
    }
}
extension Text:UnFoldable{
    /**
     * UnFolds a Text Component
     */
    static func unFold(_ dict:[String:Any],_ parent:ElementKind? = nil) -> Text{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        return Text.init(elementConfig, text)
    }
    convenience init(_ element:ElementConfig, _ text:String) {
        self.init(element.width, element.height, text, element.parent, element.id)
    }
    var data:[String:Any] {
        get{
            return [Unfold.Text.text:self.getText()]
        }set{
            if let text:String = newValue[Unfold.Text.text] as? String { self.setText(text) }
        }
    }

}
extension Element{
    struct ElementConfig{
        let width:CGFloat
        let height:CGFloat
        let parent:IElement?
        let id:String?
    }
    /**
     * Default Element config
     */
    static func elementConfig(_ dict:[String:Any], _ parent:IElement? = nil) -> ElementConfig{
        let width:CGFloat = UnFoldUtils.cgFloat(dict, "width")
        let height:CGFloat = UnFoldUtils.cgFloat(dict, "height")
        let id:String? = UnFoldUtils.string(dict, "id")
        return .init(width:width,height:height,parent:parent,id:id)
    }
}
