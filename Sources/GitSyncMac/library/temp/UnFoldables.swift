import Foundation
@testable import Utils
@testable import Element
/**
 * Key: stores keys to access getters and setters,should be moved to the individuel UI extensions
 */
extension TextInput:UnFoldable{/*<-Attaches the Unfoldable protocol to TextInput*/
    enum Key{
        static let text = "text"
        static let inputText = "inputText"
    }
    struct TextInputConfig{
        let element:ElementConfig
        let text:String
        let inputText:String
        init(_ dict:[String:Any],_ parent:IElement? = nil){
            element = .init(dict,parent)
            text = UnFoldUtils.string(dict, Key.text) ?? ""
            inputText = UnFoldUtils.string(dict, Key.inputText) ?? ""
        }
    }
    /**
     * Unfolds a TextInput component
     */
    convenience init(unfoldDict:[String:Any],parent:IElement? = nil) {
        let config:TextInputConfig = .init(unfoldDict,parent)
        self.init(config.element.width, config.element.height, config.text, config.inputText, config.element.parent, config.element.id)
    }
    var data:[String:Any] {
        get{
            //fatalError("not avilabale")
            return [Key.text:self.text.getText(),Key.inputText:self.inputTextArea.text.getText()]
        }set{
            if let text:String = newValue[Key.text] as? String { self.text.setText(text) }
            if let inputText:String = newValue[Key.inputText] as? String { self.inputTextArea.setTextValue(inputText) }
        }
    }
}
extension RadioButton{
    struct RadioButtonConfig{
        let text:String
        let isChecked:Bool
        let elementConfig:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            elementConfig = .init(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
            let isCheckedStr = UnFoldUtils.string(dict, "isChecked") ?? "false"
            isChecked = isCheckedStr.bool
        }
    }
}
extension CheckBoxButton{
    struct CheckBoxButtonConfig{
        let text:String
        let isChecked:Bool
        let elementConfig:ElementConfig
        init(_ dict:[String:Any],_ parent:ElementKind?){
            elementConfig = .init(dict,parent)
            text = UnFoldUtils.string(dict, "text") ?? ""
            let isCheckedStr = UnFoldUtils.string(dict, "isChecked") ?? "false"
            isChecked = isCheckedStr.bool
        }
    }
    /**
     * UnFolds a CheckBoxButton
     */
    convenience init(unfoldDict:[String:Any], parent:ElementKind? = nil) {
        let config:CheckBoxButtonConfig = .init(unfoldDict,parent)
        self.init(config.elementConfig.width, config.elementConfig.height,config.text,config.isChecked, config.elementConfig.parent, config.elementConfig.id)
    }
    var data:[String:Any] {
        get{
            fatalError("not availale")
        }set{
            fatalError("not availale")
        }
    }
}
extension TextButton{
    /**
     * UnFolds a TextButton Component
     */
    convenience init(unfoldDict:[String:Any], parent:IElement? = nil) {
        let elementConfig:ElementConfig = .init(unfoldDict,parent)
        let text:String = UnFoldUtils.string(unfoldDict, "text") ?? ""
        //        Swift.print("text: " + "\(text)")
        //        Swift.print("dict: " + "\(dict)")
        self.init(elementConfig.width, elementConfig.height,text, elementConfig.parent, elementConfig.id)
    }
}
extension Text:UnFoldable{
    enum Key{
        static let text = "text"
    }
    /**
     * UnFolds a Text Component
     */
    convenience init(unfoldDict:[String:Any], parent:IElement? = nil) {
        let elementConfig:ElementConfig = .init(unfoldDict,parent)
        let text:String = UnFoldUtils.string(unfoldDict, "text") ?? ""
        self.init(elementConfig.width, elementConfig.height, text, elementConfig.parent, elementConfig.id)
    }
    var data:[String:Any] {
        get{
            return [Key.text:self.getText()]
        }set{
            if let text:String = newValue[Key.text] as? String { self.setText(text) }
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
