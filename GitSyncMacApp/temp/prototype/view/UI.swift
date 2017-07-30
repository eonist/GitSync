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
        css += "fill:white,~/Desktop/ElCapitan/svg/question.svg #0A4DCB;"
        css += "Button#modalBtn{width:\(Modal.initial.w)px;height:\(Modal.initial.h)px;fill:blue;corner-radius:\(Modal.initial.fillet)px;clear:none;float:none;}"
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
