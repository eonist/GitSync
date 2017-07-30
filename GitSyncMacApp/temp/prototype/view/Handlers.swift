import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Click handler for PromptButton
     */
    func promptButtonClickHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        self.modalAnimator.setTargetValue(Modal.initial).start()/*outro modal*/
        StyleModifier.overrideStylePropVal(&self.style, ("fill",0), NSColor.blue)//reset the color again
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        self.modalBtn.addHandler(self.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
    /**
     * ForceTouch handler for modal
     */
    func forceTouchHandler(_ event:ForceTouchEvent)  {
        //Swift.print("event.type: " + "\(event.type)")
        if event.type == ForceTouchEvent.clickDown{
            Swift.print("clickDown")
            self.modalAnimator.setTargetValue(Modal.click).start()
        }else if event.type == ForceTouchEvent.deepClickDown{
            Swift.print("deepClickDown")
            self.modalAnimator.setTargetValue(Modal.expanded).start()//Swift.print("window.contentView.localPos(): " + "\(window.contentView!.localPos())")
            self.onMouseDownMouseY  = self.window!.contentView!.localPos().y
            NSEvent.addMonitor(&self.leftMouseDraggedMonitor,.leftMouseDragged,self.leftMouseDraggedClosure)
        }else if event.type == ForceTouchEvent.clickUp {
            Swift.print("clickUp")
            if !self.modalStayMode {//modal stay
                self.modalAnimator.setTargetValue(Modal.initial).start()
            }
        }else if event.type == ForceTouchEvent.deepClickUp {
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
        if event.type == ForceTouchEvent.stageChange {/*when forcetouch changes state*/
            let stage:Int = event.stage
            Swift.print("stage: " + "\(stage)")
            if stage == 0 {
                if !self.modalStayMode {
                    modalBtn.setAppearance(<#T##point: CGPoint##CGPoint#>)
                    StyleModifier.overrideStylePropVal(&self.style, ("fill",0), NSColor.blue)
                    Swift.print("override to blue")
                }
            }else if stage == 1{
                if !self.modalStayMode && event.prevStage == 0{ //only change to red if prev stage was 0
                    StyleModifier.overrideStylePropVal(&self.style, ("fill",0), NSColor.red)
                    Swift.print("override to red")
                }
                
            }else /*if stage == 2*/{
                if !self.modalStayMode {
                    StyleModifier.overrideStylePropVal(&self.style, ("fill",0), NSColor.green)
                    Swift.print("override to green")
                }
                
            }
        }
        
        disableAnim {
            self.modalBtn.skin?.setStyle(self.style)
        }
    }
    /**
     * Drag handler for modal
     */
    func leftMouseDraggedClosure(event:NSEvent)  {
        let relativePos:CGFloat =  self.onMouseDownMouseY - self.window!.contentView!.localPos().y
        //Swift.print("relativePos: " + "\(relativePos)")
        var newRect = Modal.expanded
        newRect.y -= relativePos
        self.modalAnimator.direct = true
        self.modalAnimator.setTargetValue(newRect).start()
        if self.modalAnimator.value.y < 30  {//modal in stayMode
            self.modalStayMode = true
            Swift.print("reveal buttons: \(self.modalAnimator.value.y)")
            var p = self.modalAnimator.value.rect.bottomLeft
            p.y += 15//add some margin
            p.y = p.y.max(PromptButton.expanded.y)
            //
            self.promptBtnAnimator.setTargetValue(p).start()//you could do modalBtn.layer.origin + getHeight etc.
        }else if self.modalAnimator.value.y > 30 {//modal in leaveMode
            self.modalStayMode = false
            Swift.print("anim buttons out")
            self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start() //anim bellow screen
        }
    }
}
