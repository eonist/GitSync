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
        StyleManager.addStyle(Styles.Modal.initial)
        let btn = self.addSubView(ForceTouchButton(Modal.initial.size.w,Modal.initial.size.h,nil,"modalBtn"))
        btn.point = Modal.initial.origin//center button
        return btn
    }
    /**
     * Returns Prompt Button
     */
    func createPromptButton() -> Button{
        StyleManager.addStyle(Styles.PromptButton.initial)
        let btn = self.addSubView(Button(Modal.initial.w,Modal.initial.h,nil,"prompt"))
        btn.layer?.position = PromptButton.initial.origin//out of view
        return btn
    }
}
