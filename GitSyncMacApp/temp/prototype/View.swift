import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
    /*UI*/
    lazy var modalBtn:Button = self.createModalButton(Modal.initial.origin)
    lazy var promptBtn:TextButton = self.createPromptButton()
    /*Animation*/
    lazy var promptBtnAnimator:Easer5<CGPoint> = Easer5<CGPoint>(AnimState.PromptButton.initial, DefaultEasing.point,self.promptButtonAnim)
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(AnimState.Modal.initial, RoundedRect.DefaultEasing.easing,Constraint.content,Constraint.mask,self.modalFrameAnim)
    /*Values*/
    var modalStayMode:Bool = false/*This is set to true if modal is released above a sertion threshold (modal.y < 30) threshold*/
    var leftMouseDraggedMonitor:Any?/*Handler for dragging modal*/
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    
    override func resolveSkin(){
        Swift.print("ProtoTypeView.resolveSkin()")
        StyleManager.addStyle("Window{fill:white;}")//padding-top:24px;
        super.resolveSkin()
        createUI()
        addEventHandlers()
    }
    /**
     * Create the UI
     */
    func createUI(){
        _ = modalBtn
        _ = promptBtn
    }
    /**
     * Adds eventHandlers to UI
     */
    func addEventHandlers(){
        modalBtn.addHandler(forceTouchHandler)
        promptBtn.addHandler(type:ButtonEvent.upInside,promptButtonClickHandler)
    }
    /**
     * New
     */
    func indexOfModal(_ modal:NSView?)->Int{
        if modal === modalBtn {
            return 1
        }else{
            fatalError("add more buttons")
        }
    }
}

//Continue here 🏀
    //Use SF font?
    //Use ligthning svg
    //add more Modal buttons to window 
        //move forceTouch handler into a ModalButton Class
            //roll back to working mode 👈
            //move modal animator into MOdalButton class
            //move LeftMOuseDrag into ModalBUtton class
        //refactor enum constants to support more buttons
    //create the fullScreenMode
    //add the pan left and right gesture handler
    //pinch out back into initial mode
    //swipe in buttons
        //swipe out buttons



