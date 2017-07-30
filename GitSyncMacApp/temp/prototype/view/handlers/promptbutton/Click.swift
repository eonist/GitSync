import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Click handler for PromptButton
     */
    func promptButtonClickHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        modalBtn.modalAnimator.setTargetValue(Modal.initial).start()/*outro modal*/
        modalBtn.setAppearance(Colors.Modal.initial)//reset the color again
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        self.modalBtn.addHandler(self.modalBtn.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
}
