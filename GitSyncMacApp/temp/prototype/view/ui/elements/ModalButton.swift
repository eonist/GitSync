import Cocoa
@testable import Utils
@testable import Element

class ModalButton:ForceTouchButton{

}
extension ModalButton{
    /**
     * ForceTouch handler for modal
     */
    func forceTouchHandler(_ event:ForceTouchEvent)  {
        //let indexOfModal:Int = self.indexOfModal(event.origin)
        //Swift.print("event.type: " + "\(event.type)")
        if event.type == ForceTouchEvent.clickDown{//TODO: use switch
            clickDown()
        }else if event.type == ForceTouchEvent.clickUp {
            clickUp()
        }else if event.type == ForceTouchEvent.deepClickDown{
            deepClickDown()
        }else if event.type == ForceTouchEvent.deepClickUp {
            deepClickUp()
        }
        if event.type == ForceTouchEvent.stageChange {
            stageChange(event)
        }
    }
    private func clickDown(){
        Swift.print("clickDown")
        ProtoTypeView.shared.modalAnimator.setTargetValue(ProtoTypeView.Modal.click).start()
    }
    private func clickUp(){
        Swift.print("clickUp")
        if !ProtoTypeView.shared.modalStayMode {//modal stay
            ProtoTypeView.shared.modalAnimator.setTargetValue(ProtoTypeView.Modal.initial).start()
        }
    }
    private func deepClickDown(){
        Swift.print("deepClickDown")
        ProtoTypeView.shared.modalAnimator.setTargetValue(ProtoTypeView.Modal.expanded).start()//Swift.print("window.contentView.localPos(): " + "\(window.contentView!.localPos())")
        ProtoTypeView.shared.onMouseDownMouseY  = self.window!.contentView!.localPos().y
        NSEvent.addMonitor(&ProtoTypeView.shared.leftMouseDraggedMonitor,.leftMouseDragged,ProtoTypeView.shared.leftMouseDraggedClosure)
    }
    private func deepClickUp(){
        Swift.print("deepClickUp")
        if ProtoTypeView.shared.modalStayMode {/*modal stay*/
            Swift.print("modal stay")
            ProtoTypeView.shared.modalBtn.removeHandler()
            ProtoTypeView.shared.modalAnimator.direct = false
            var rect = ProtoTypeView.Modal.expanded
            rect.origin.y -= 30
            ProtoTypeView.shared.modalAnimator.setTargetValue(rect).start()
        }else{/*modal leave*/
            Swift.print("modal leave")
            ProtoTypeView.shared.modalAnimator.direct = false
            ProtoTypeView.shared.modalAnimator.setTargetValue(ProtoTypeView.Modal.initial).start()
            /*promptBtn*/
            ProtoTypeView.shared.promptBtnAnimator.setTargetValue(ProtoTypeView.PromptButton.initial.origin).start() //anim bellow screen
        }
        NSEvent.removeMonitor(&ProtoTypeView.shared.leftMouseDraggedMonitor)
    }
    /**
     * when forcetouch changes state
     */
    private func stageChange(_ event:ForceTouchEvent){
        let stage:Int = event.stage
        //Swift.print("stage: " + "\(stage)")
        if stage == 0 && !ProtoTypeView.shared.modalStayMode{
            ProtoTypeView.shared.modalBtn.setAppearance(Colors.Modal.initial)
        }else if stage == 1 && !ProtoTypeView.shared.modalStayMode && event.prevStage == 0{//only change to red if prev stage was 0
            ProtoTypeView.shared.modalBtn.setAppearance(Colors.Modal.click)
        }else if stage == 2 && !ProtoTypeView.shared.modalStayMode{
            ProtoTypeView.shared.modalBtn.setAppearance(Colors.Modal.expanded)
        }
    }
}
