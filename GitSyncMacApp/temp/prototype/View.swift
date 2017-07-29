import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
    /*UI*/
    lazy var modalBtn:Button = self.createModal()
    lazy var promptBtn:Button = self.createPromptButton()
    /*Animation*/
    lazy var promptBtnAnimator:Easer5<CGPoint> = Easer5<CGPoint>(initPromptButtonAnimState, DefaultEasing.point,self.promptButtonAnim)
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(initModalState, DefaultEasing.rect,Constraint.content,Constraint.mask,self.modalFrameAnim)
    /*Values*/
    var modalStayMode:Bool = false/*this is set to true if modal is released above a sertion threshold (modal.y < 30) threshold*/
    var leftMouseDraggedMonitor:Any?
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    lazy var style:Style = self.modalBtn.skin!.style! as! Style
    
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
     * Adds eventHandlers
     */
    func addEventHandlers(){
        modalBtn.addHandler(forceTouchHandler)
        promptBtn.addHandler(type:ButtonEvent.upInside,promptButtonHandler)
    }
}
