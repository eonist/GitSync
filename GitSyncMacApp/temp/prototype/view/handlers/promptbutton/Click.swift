import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Click handler for PromptButton
     */
    func promptButtonClickHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        guard let curModal:ModalButton = curModal else{return}
        curModal.modalAnimator.setTargetValue(Modal.initial(curModal.index)).start()/*outro modal*/
        curModal.setAppearance(Colors.Modal.initial)//reset the color again
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        curModal.addHandler(curModal.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
}
