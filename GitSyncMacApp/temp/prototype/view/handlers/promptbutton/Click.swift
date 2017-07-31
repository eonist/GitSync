import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Click handler for PromptButton
     */
    func promptButtonClickHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        promptBtn.setAppearance(Colors.PromptButton.Background.idle)
        self.curModal.modalAnimator.setTargetValue(Modal.initial(self.curModal.index)).start()/*outro modal*/
        self.curModal.setAppearance(Colors.Modal.initial(self.curModal.index))//reset the color again
        self.curModal.toggleFocusForOtherButtons(.focused)//reset focus state of other buttons
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        self.curModal.addHandler(self.curModal.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
}
