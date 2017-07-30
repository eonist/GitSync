import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Click handler for PromptButton
     */
    func promptButtonClickHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        guard let curModalBtn:ModalButton = self.curModal else{return}
        curModalBtn.modalAnimator.setTargetValue(Modal.initial(curModalBtn.index)).start()/*outro modal*/
        curModalBtn.setAppearance(Colors.Modal.initial(curModalBtn.index))//reset the color again
        curModalBtn.toggleFocusForOtherButtons(.focused)//reset focus state of other buttons
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        curModalBtn.addHandler(curModalBtn.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
}
