import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * ForceTouch handler for modal
     */
    func forceTouchHandler(_ event:ForceTouchEvent)  {
        //Swift.print("event.type: " + "\(event.type)")
        if event.type == ForceTouchEvent.clickDown{
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
        self.modalAnimator.setTargetValue(Modal.click).start()
    }
    private func clickUp(){
        Swift.print("clickUp")
        if !self.modalStayMode {//modal stay
            self.modalAnimator.setTargetValue(Modal.initial).start()
        }
    }
    private func deepClickDown(){
        Swift.print("deepClickDown")
        self.modalAnimator.setTargetValue(Modal.expanded).start()//Swift.print("window.contentView.localPos(): " + "\(window.contentView!.localPos())")
        self.onMouseDownMouseY  = self.window!.contentView!.localPos().y
        NSEvent.addMonitor(&self.leftMouseDraggedMonitor,.leftMouseDragged,self.leftMouseDraggedClosure)
    }
    private func deepClickUp(){
        Swift.print("deepClickUp")
        if self.modalStayMode {/*modal stay*/
            Swift.print("modal stay")
            self.modalBtn.removeHandler()
            self.modalAnimator.direct = false
            var rect = Modal.expanded
            rect.origin.y -= 30
            self.modalAnimator.setTargetValue(rect).start()
        }else{/*modal leave*/
            Swift.print("modal leave")
            self.modalAnimator.direct = false
            self.modalAnimator.setTargetValue(Modal.initial).start()
            /*promptBtn*/
            self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start() //anim bellow screen
        }
        NSEvent.removeMonitor(&self.leftMouseDraggedMonitor)
    }
    /**
     * when forcetouch changes state
     */
    private func stageChange(_ event:ForceTouchEvent){
        let stage:Int = event.stage
        //Swift.print("stage: " + "\(stage)")
        if stage == 0 && !self.modalStayMode{
            modalBtn.setAppearance(Colors.Modal.initial)
        }else if stage == 1 && !self.modalStayMode && event.prevStage == 0{//only change to red if prev stage was 0
            modalBtn.setAppearance(Colors.Modal.click)
        }else if stage == 2 && !self.modalStayMode{
            modalBtn.setAppearance(Colors.Modal.expanded)
        }
    }
}
