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
    func createModalButton(_ i:Int) -> ModalButton{
        StyleManager.addStyle(Styles.ModalButton.initial(i))/*Add css styling*/
        let btn = self.addSubView(ModalButton(Modal.initial().size.w,Modal.initial().size.h,nil,i.string))
        btn.point = Modal.initial(i).origin//position button
        return btn
    }
    /**
     * Returns Prompt Button
     */
    func createPromptButton() -> TextButton{
        StyleManager.addStyle(Styles.PromptButton.initial)/*Add css styling*/
        //TODO: ⚠️️ the bellow sizes seem wrong
        let btn = self.addSubView(TextButton(Modal.initial().w,Modal.initial().h,"Dismiss",nil))
        btn.layer?.position = PromptButton.initial.origin//out of view
        return btn
    }
}
