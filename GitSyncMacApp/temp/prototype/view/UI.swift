import Cocoa
@testable import Utils
@testable import Element
/**
 * Constants
 */
extension ProtoTypeView {
    /**
     * Returns Modal UI
     */
    func createModal() -> ForceTouchButton{
        var css:String = ""
        css += "Button#modalBtn{"
        css += "fill:blue,~/Desktop/ElCapitan/svg/question.svg red;"//fill:blue;
        css += "width:\(Modal.initial.w)px,50px;"
        css += "height:\(Modal.initial.h)px,50px;"
        css += "corner-radius:\(Modal.initial.fillet)px;"
        css += "margin-top:0px,25px;"
        css += "margin-left:0px,25px;"
        css += "clear:none;"
        css += "float:none;"
        css += "}"
        StyleManager.addStyle(css)
        let btn = self.addSubView(ForceTouchButton(Modal.initial.size.w,Modal.initial.size.h,nil,"modalBtn"))
        btn.point = Modal.initial.origin//center button
        return btn
    }
    /**
     * Returns Prompt Button
     */
    func createPromptButton() -> Button{
        var css:String = ""
        css += "Button#prompt{width:\(PromptButton.initial.size.w)px;height:\(PromptButton.initial.size.h);fill:purple;corner-radius:20px;clear:none;float:none;}"
        css += "Button#prompt:down{fill:grey;}"
        
        StyleManager.addStyle(css)
        
        let btn = self.addSubView(Button(Modal.initial.w,Modal.initial.h,nil,"prompt"))
        btn.layer?.position = PromptButton.initial.origin//out of view
        return btn
    }
}
