import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
    /*UI*/
    lazy var modalBtn:Button = self.createModal()
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
}

//Continue here 🏀
    //PromptButton must be TextButton ✅
        //Use SF font? 🤔 DO IT! 😊
    //Use ligthning svg 👈
    //add more Modal buttons to window
