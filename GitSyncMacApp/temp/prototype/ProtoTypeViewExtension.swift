import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Constants
     */
    enum WinRect {
        static let size:CGSize = CGSize(200,355)//IPhone 7: (750 x 1334) (375 x 667) ≈ (200x355)
        static let point:CGPoint = CGPoint(0,0)
    }
    enum Modal {
        static let initial:CGRect = {//init modal btn size
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        static let click:CGRect = {//when modalBtn is pressed down
            let size:CGSize = Modal.initial.size * 0.75
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        static let expanded:CGRect = {//when modal is in expanded mode
            let size = CGSize(WinRect.size.w,WinRect.size.w) - CGSize(40,0)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
    }
    enum PromptButton {
        static let initial:CGRect = {
            let size:CGSize = CGSize(Modal.expanded.size.w,45)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.bottomCenter, Alignment.topCenter)
            return CGRect(p,size)
        }()
        static let expanded:CGPoint = {//the limit of where promptButton can go vertically
            return initial.origin - CGPoint(0,initial.height + 20/*<--bottom margin*/)
        }()
    }
    enum Constraint{
        static let mask:ElasticEaser5.Frame = (WinRect.point.y,WinRect.size.h)
        static let content:ElasticEaser5.Frame = (Modal.expanded.y,Modal.expanded.h)
    }
    /**
     * Handlers
     */
    func promptButtonHandler(_ event:ButtonEvent) { /*Handler for promptBtn*/
        Swift.print("promptBtn.upInside")
        self.modalAnimator.setTargetValue(Modal.initial).start()/*outro modal*/
        self.promptBtnAnimator.setTargetValue(PromptButton.initial.origin).start()/*outro promptBtn*/
        self.modalBtn.addHandler(self.forceTouchHandler)//re-Added forcetoucheventhandler, ideally add this handler on outro complete
        self.modalStayMode = false//release modalStayMode
    }
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
}
