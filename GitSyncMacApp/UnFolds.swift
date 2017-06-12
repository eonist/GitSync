import Foundation
@testable import Utils
@testable import Element

extension TextInput{
    /**
     * New
     */
    static func unFold(_ dict:[String:Any],_ parent:IElement?) -> TextInput{
        let elementConfig:ElementConfig = Element.elementConfig(dict)
        //config tuple
        return TextInput(NaN,NaN,"","",nil)
    }
    typealias TextInputConfig = (text:String, inputText:String)
    convenience init(element:ElementConfig, config:TextInputConfig) {
        self.init(element.width, element.height, config.text, config.inputText, element.parent, element.id)
    }
    
}
extension Element{
    typealias ElementConfig = (width:CGFloat, height:CGFloat, parent:IElement?, id:String?)
    /**
     * New
     */
    static func elementConfig(_ dict:[String:Any], _ parent:IElement? = nil) -> ElementConfig{
        let width:CGFloat = UnFoldUtils.cgFloat(dict, "width")
        let height:CGFloat = UnFoldUtils.cgFloat(dict, "height")
        let id:String? = UnFoldUtils.string(dict, "id")
        return (width:width,height:height,parent:parent,id:id)
    }
}
