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
    lazy var modalBtn:Button = {
        StyleManager.addStyle("Button#modalBtn{width:\(Modal.initial.size.w)px;height:\(Modal.initial.size.h)px;fill:blue;corner-radius:20px;clear:none;float:none;}")
        let btn = self.addSubView(ForceTouchButton(Modal.initial.size.w,Modal.initial.size.h,nil,"modalBtn"))
        btn.point = Modal.initial.origin//center button
        return btn
    }()
    lazy var promptBtn:Button = {
        var css:String = ""
        css += "Button#prompt{width:\(PromptButton.initial.size.w)px;height:\(PromptButton.initial.size.h);fill:purple;corner-radius:20px;clear:none;float:none;}"
        css += "Button#prompt:down{fill:grey;}"
        
        StyleManager.addStyle(css)
        
        let btn = self.addSubView(Button(Modal.initial.w,Modal.initial.h,nil,"prompt"))
        btn.layer?.position = PromptButton.initial.origin//out of view
        return btn
    }()
    
    lazy var style:Style = self.modalBtn.skin!.style! as! Style
    static var initModalState:AnimState5<CGRect> = .init(Modal.initial)//set initial value
    /*Animation*/
    lazy var modalAnimator = ElasticEaser5(initModalState, DefaultEasing.rect,Constraint.content,Constraint.mask) { (rect:CGRect) in
        //anim rect here buttonRect to modalRect
        //Swift.print("rect: " + "\(rect)")
        disableAnim {
            StyleModifier.overrideStylePropVal(&self.style, ("width",0), rect.size.w)
            StyleModifier.overrideStylePropVal(&self.style, ("height",0), rect.size.h)
            self.modalBtn.skin?.setStyle(self.style)
            self.modalBtn.layer?.position = rect.origin
        }
    }
    static var initPromptButtonAnimState:AnimState5<CGPoint> = .init(PromptButton.initial.origin)//set initial value
    lazy var promptBtnAnimator:Easer5<CGPoint> = Easer5<CGPoint>(initPromptButtonAnimState, DefaultEasing.point){ point in
        disableAnim {
            self.promptBtn.layer?.position = point
        }
    }
    var modalStayMode:Bool = false//this is set to true if modal is released above a sertion threshold (modal.y < 30) threshold
    var leftMouseDraggedMonitor:Any?
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    /*EventHandlers*/
    lazy var leftMouseDraggedClosure:NSEvent.CallBack = {_ in
            let relativePos:CGFloat =  self.onMouseDownMouseY - self.window!.contentView!.localPos().y
            //Swift.print("relativePos: " + "\(relativePos)")
            var newRect = Modal.expanded
            newRect.y -= relativePos
            self.modalAnimator.direct = true
            self.modalAnimator.setTargetValue(newRect).start()
            if self.modalAnimator.value.y < 30  {//modal in stayMode
                self.modalStayMode = true
                Swift.print("reveal buttons: \(self.modalAnimator.value.y)")
                var p = self.modalAnimator.value.bottomLeft
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
