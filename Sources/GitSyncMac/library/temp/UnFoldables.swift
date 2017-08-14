import Foundation
@testable import Utils
@testable import Element
/**
 * NOTE: Key: stores keys to access getters and setters,should be moved to the individuel UI extensions
 * NOTE: The structs are nice if you want to sub-class Components, then they can be re-used, avoids duplicate code
 * NOTE: We use static func unfold instead of .init. As .init would clutter up Element.init. always favour KISS
 */
extension TextInput:UnFoldable{/*<-Attaches the Unfoldable protocol to TextInput*/
    enum Key{
        static let text = "text"
        static let inputText = "inputText"
    }
    struct Config{
        let element:ElementConfig
        let text:String
        let inputText:String
        init(_ dict:[String:Any],_ parent:IElement? = nil){
            element = .init(dict,parent)
            text = UnFoldUtils.string(dict, Key.text) ?? ""
            inputText = UnFoldUtils.string(dict, Key.inputText) ?? ""
        }
    }
    static func unfold(_ unfoldDict:[String:Any],_ parent:IElement? = nil) -> TextInput{
        let config:Config = .init(unfoldDict,parent)
        return TextInput.init(config.element.width, config.element.height, config.text, config.inputText, config.element.parent, config.element.id)
    }
}
extension FilePicker{
    func setData(text:String,input:String,buttonText:String){
        //Continue here: Add unfold
    }
}
extension TextArea:UnFoldable{
    enum Key{
        static let text = "text"
    }
    static func unfold(_ unfoldDict:[String:Any], _ parent:ElementKind? = nil) -> TextArea{
        let elementConfig:ElementConfig = .init(unfoldDict,parent)
        let text:String = UnFoldUtils.string(unfoldDict, "text") ?? ""
        return TextArea.init(elementConfig.width, elementConfig.height, text, elementConfig.parent, elementConfig.id)
    }
    var value:Any {
        get{
            return self.getTextValue()
        }set{
            if let newValue:String = newValue as? String { self.setTextValue(newValue) }
        }
    }
}
extension RadioButton{
    struct Config{
        let text:String
        let isSelected:Bool
        let element:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            element = .init(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
            let isSelectedStr = UnFoldUtils.string(dict, "isSelected") ?? "false"
            isSelected = isSelectedStr.bool
        }
    }
    static func unfold(radioButtonUnfoldDict unfoldDict:[String:Any], _ parent:IElement? = nil) -> RadioButton{
//        Swift.print("RadioButton.unfold")
        let config:Config = .init(unfoldDict,parent)
//        Swift.print("config: " + "\(config)")
        let retVal = RadioButton.init(config.element.width, config.element.height,config.text,config.isSelected, config.element.parent, config.element.id)
//        Swift.print("after retval")
        return retVal
    }
    var value: Any {
        get {
           return getSelected()
        }set{
            if let newValue = newValue as? Bool {setSelected(newValue)}
        }
    }
}
extension CheckBoxButton:UnFoldable{
    struct CheckBoxButtonConfig{
        let text:String
        let isChecked:Bool
        let element:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            element = .init(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
            let isCheckedStr = UnFoldUtils.string(dict, "isChecked") ?? "false"
            isChecked = isCheckedStr.bool
        }
    }
    /**
     * UnFolds a CheckBoxButton
     */
    static func unfold(_ unfoldDict:[String:Any], _ parent:ElementKind? = nil) -> CheckBoxButton{
        let config:CheckBoxButtonConfig = .init(unfoldDict,parent)
        return CheckBoxButton.init(config.element.width, config.element.height, config.text, config.isChecked, config.element.parent, config.element.id)
    }
    var value: Any {
        get {
            Swift.print("CheckBoxButton.getChecked(): \(getChecked())")
            return getChecked()
        }set{
            if let newValue = newValue as? Bool {setChecked(newValue)}
        }
    }
}
extension TextButton:UnFoldable{
    struct TextButtonConfig{
        let text:String
        let element:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            element = .init(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
        }
    }
    static func unfold(_ unfoldDict:[String:Any], _ parent:IElement?) -> TextButton {
        let config:TextButtonConfig = .init(unfoldDict,parent)
        return TextButton.init(config.element.width, config.element.height,config.text, config.element.parent, config.element.id) 
    }
   
}
extension Text:UnFoldable{
    enum Key{
        static let text = "text"
    }
    static func unfold(_ unfoldDict:[String:Any], _ parent:ElementKind? = nil) -> Text{
        let elementConfig:ElementConfig = .init(unfoldDict,parent)
        let text:String = UnFoldUtils.string(unfoldDict, "text") ?? ""
        return Text.init(elementConfig.width, elementConfig.height, text, elementConfig.parent, elementConfig.id)
    }
    var value:Any {
        get{
            return self.getText()
        }set{
            if let newValue:String = newValue as? String { self.setText(newValue) }
        }
    }
}
extension Element{
    struct ElementConfig{/*Default Element config*/
        let width:CGFloat
        let height:CGFloat
        let parent:IElement?
        let id:String?
        init(_ dict:[String:Any],_ parent:ElementKind? = nil){
            width = UnFoldUtils.cgFloat(dict, "width")
            height = UnFoldUtils.cgFloat(dict, "height")
            self.parent = parent
            id = UnFoldUtils.string(dict, "id")
        }
    }
}
