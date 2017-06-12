import Foundation
@testable import Utils
@testable import Element

extension TextInput{
    typealias TextInputConfig = (text:String, inputText:String)
    /**
     * New
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> TextInput{
        Swift.print("TextInput.unFold")
        let elementConfig:ElementConfig = Element.elementConfig(dict)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        let inputText:String = UnFoldUtils.string(dict, "inputText") ?? ""
        let config:TextInputConfig = (text:text,inputText:inputText)
        let textInput:TextInput = TextInput.init(elementConfig, config)
        Swift.print("after init")
        return textInput
    }
    convenience init(_ element:ElementConfig, _ config:TextInputConfig) {
        Swift.print("TextInput.init")
        Swift.print("element.id: " + "\(element.id)")
        Swift.print("element.width: " + "\(element.width)")
        Swift.print("element.height: " + "\(element.height)")
        Swift.print("config.text: " + "\(config.text)")
        Swift.print("element.parent: " + "\(element.parent)")
        self.init(element.width, element.height, config.text, config.inputText, element.parent, element.id)
        Swift.print("after")
    }
}
extension CheckBoxButton{
    typealias CheckBoxButtonConfig = (text:String, isChecked:Bool)
    /**
     * New
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement? = nil) -> CheckBoxButton{
        let elementConfig:ElementConfig = Element.elementConfig(dict)
        let text:String = UnFoldUtils.string(dict, "text") ?? ""
        let isCheckedStr:String = UnFoldUtils.string(dict, "isChecked") ?? "false"
        let config:CheckBoxButtonConfig = (text:text,isChecked:isCheckedStr.bool)
        return CheckBoxButton.init(elementConfig, config)
    }
    convenience init(_ element:ElementConfig, _ config:CheckBoxButtonConfig) {
        self.init(element.width, element.height,"",false, element.parent, element.id)
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
