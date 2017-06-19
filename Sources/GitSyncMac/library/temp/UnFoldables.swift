import Foundation
@testable import Utils
@testable import Element

extension TextInput:UnFoldable{/*<-Attaches the Unfoldable protocol to TextInput*/
    typealias TextInputConfig = (text:String, inputText:String)
    /**
     * Unfolds a TextInput component
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> TextInput{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        let inputText:String = UnFoldUtils.string(dict, "inputText") ?? ""
        let config:TextInputConfig = (text:text,inputText:inputText)
        let textInput:TextInput = TextInput.init(elementConfig, config)
        return textInput
    }
    convenience init(_ element:ElementConfig, _ config:TextInputConfig) {
        self.init(element.width, element.height, config.text, config.inputText, element.parent, element.id)
    }
    var data:[String:Any] {
        get{fatalError("not avilabale")}
        set{
            if let text:String = newValue["text"] as? String { self.text.setText(text) }
            if let inputText:String = newValue["inputText"] as? String { self.inputTextArea.setTextValue(inputText) }
        }
    }
}
extension CheckBoxButton{
    typealias CheckBoxButtonConfig = (text:String, isChecked:Bool)
    /**
     * UnFolds a CheckBoxButton
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> CheckBoxButton{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        let isCheckedStr:String = UnFoldUtils.string(dict, "isChecked") ?? "false"
        let config:CheckBoxButtonConfig = (text:text,isChecked:isCheckedStr.bool)
        return CheckBoxButton.init(elementConfig, config)
    }
    convenience init(_ element:ElementConfig, _ config:CheckBoxButtonConfig) {
        self.init(element.width, element.height,config.text,config.isChecked, element.parent, element.id)
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
        let config:TextButtonConfig = (text:text)
        return TextButton.init(elementConfig, config)
    }
    convenience init(_ element:ElementConfig, _ config:TextButtonConfig) {
        self.init(element.width, element.height,config, element.parent, element.id)
    }
}
extension Text{
    /**
     * UnFolds a Text Component
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> Text{
        let elementConfig:ElementConfig = Element.elementConfig(dict,parent)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        return Text.init(elementConfig, text)
    }
    convenience init(_ element:ElementConfig, _ text:String) {
        self.init(element.width, element.height, text, element.parent, element.id)
    }
}
extension Element{
    typealias ElementConfig = (width:CGFloat, height:CGFloat, parent:IElement?, id:String?)
    /**
     * Default Element config
     */
    static func elementConfig(_ dict:[String:Any], _ parent:IElement? = nil) -> ElementConfig{
        let width:CGFloat = UnFoldUtils.cgFloat(dict, "width")
        let height:CGFloat = UnFoldUtils.cgFloat(dict, "height")
        let id:String? = UnFoldUtils.string(dict, "id")
        return (width:width,height:height,parent:parent,id:id)
    }
}
