import Cocoa
@testable import Utils
@testable import Element
//Continue here 🏀
    //1. Add some design elements (the goal today is to refactor, then add the design to the anim and make a gif with iphone template, and launch Animator, ElementiOS and update ElementMacOS, and write article aout prototyping with swift and playground)
    //make Element extension that implements Animatable. Which lets you change: size,pos,color ⚠️️
    // I think you can extract the Constrainer for the animator into a static class instead of extending 👈
    //svg?
    //USe func instead of var to move handlers into extensions
class ProtoTypeView:WindowView{
    /*UI*/
    lazy var modalBtn:Button = self.createModal()
    lazy var promptBtn:Button = self.createPromptButton()
    
    lazy var style:Style = self.modalBtn.skin!.style! as! Style
    static var initModalState:AnimState5<CGRect> = .init(Modal.initial)//set initial value
    /*Animation*/
    
    lazy var promptBtnAnimator:Easer5<CGPoint> = Easer5<CGPoint>(initPromptButtonAnimState, DefaultEasing.point,self.promptButtonAnim)
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(initModalState, DefaultEasing.rect,Constraint.content,Constraint.mask,self.modalFrameAnim)
    
    var modalStayMode:Bool = false/*this is set to true if modal is released above a sertion threshold (modal.y < 30) threshold*/
    var leftMouseDraggedMonitor:Any?
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
     * Adds eventHandlers
     */
    func addEventHandlers(){
        modalBtn.addHandler(forceTouchHandler)
        promptBtn.addHandler(type:ButtonEvent.upInside,promptButtonHandler)
    }
}
