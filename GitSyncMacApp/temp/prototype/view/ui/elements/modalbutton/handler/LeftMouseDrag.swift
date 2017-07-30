import Foundation
import Cocoa
@testable import Utils
@testable import Element

extension ModalButton {
    /**
     * Drag handler for modal
     */
    func leftMouseDraggedClosure(event:NSEvent)  {
        let relativePos:CGFloat =  self.onMouseDownMouseY - self.window!.contentView!.localPos().y
        //Swift.print("relativePos: " + "\(relativePos)")
        var newRect = ProtoTypeView.Modal.expanded
        newRect.y -= relativePos
        modalAnimator.direct = true
        modalAnimator.setTargetValue(newRect).start()
        if modalAnimator.value.y < 30  {//modal in stayMode
            ProtoTypeView.shared.modalStayMode = true
            //Swift.print("reveal buttons: \(modalBtn.modalAnimator.value.y)")
            var p = modalAnimator.value.rect.bottomLeft
            p.y += 15//add some margin
            p.y = p.y.max(ProtoTypeView.PromptButton.expanded.y)
            //
            ProtoTypeView.shared.promptBtnAnimator.setTargetValue(p).start()//you could do modalBtn.layer.origin + getHeight etc.
        }else if modalAnimator.value.y > 30 {//modal in leaveMode
            ProtoTypeView.shared.modalStayMode = false
            Swift.print("anim buttons out")
            ProtoTypeView.shared.promptBtnAnimator.setTargetValue(ProtoTypeView.PromptButton.initial.origin).start() //anim bellow screen
        }
    }
}
