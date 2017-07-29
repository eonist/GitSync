import Cocoa
@testable import Utils
@testable import Element

class ProtoTypeView:WindowView{
    var winRect:CGRect  {return CGRect(0,0,self.width,self.height)}
    lazy var section = {
        StyleManager.addStyle("#bg{fill:white;padding-top:24px;}")
        _ = self.addSubView(Section(self.winRect.w,self.winRect.h,nil,"bg"))
    }
    enum ModalRect {
        case initial:CGSize = CGSize()
    }
    
    override func resolveSkin(){
        Swift.print("ProtoTypeView")
        
        super.resolveSkin()
        _ = section
        
        let initModalRect:CGRect = {//init modal btn size
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        let clickModeRect:CGRect = {//when modalBtn is pressed down
            let size:CGSize = initModalRect.size * 0.75
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        let modalRect:CGRect = {//when modal is in expanded mode
            let size = CGSize(winRect.size.w,winRect.size.w) - CGSize(40,0)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        /**
         * ModalBtn
         */
    
        let modalBtn:Button = {//button
            StyleManager.addStyle("Button#modalBtn{width:\(initModalRect.size.w)px;height:\(initModalRect.size.h)px;fill:blue;corner-radius:20px;clear:none;float:none;}")
            let btn = self.addSubView(ForceTouchButton(initModalRect.size.w,initModalRect.size.h,nil,"modalBtn"))
            btn.point = initModalRect.origin//center button
            return btn
        }()
        
        var style:Style = modalBtn.skin!.style! as! Style
        
        let maskFrame:ElasticEaser5.Frame = (winRect.y,winRect.h)
        let contentFrame:ElasticEaser5.Frame = (modalRect.y,modalRect.h)
        let modalAnimator = ElasticEaser5(CGRect.defaults, DefaultEasing.rect,contentFrame,maskFrame) { (rect:CGRect) in
            //anim rect here buttonRect to modalRect
            //Swift.print("rect: " + "\(rect)")
            disableAnim {
                StyleModifier.overrideStylePropVal(&style, ("width",0), rect.size.w)
                StyleModifier.overrideStylePropVal(&style, ("height",0), rect.size.h)
                modalBtn.skin?.setStyle(style)
                modalBtn.layer?.position = rect.origin
            }
        }
        modalAnimator.value = initModalRect
        
        /**
         * PromptBtn
         */
        
        let initPromptBtnRect:CGRect = {
            let size:CGSize = CGSize(modalRect.size.w,45)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.bottomCenter, Alignment.topCenter)
            return CGRect(p,size)
        }()
        let maxPromptBtnPoint = {//the limit of where promptButton can go vertically
            return initPromptBtnRect.origin - CGPoint(0,initPromptBtnRect.height + 20/*<--bottom margin*/)
        }()
        
        let promptBtn:Button = {//button
            var css:String = ""
            css += "Button#prompt{width:\(initPromptBtnRect.size.w)px;height:\(initPromptBtnRect.size.h);fill:purple;corner-radius:20px;clear:none;float:none;}"
            css += "Button#prompt:down{fill:grey;}"
            StyleManager.addStyle(css)
            
            let btn = self.addSubView(Button(initModalRect.size.w,initModalRect.size.h,nil,"prompt"))
            btn.layer?.position = initPromptBtnRect.origin//out of view
            return btn
        }()
        
        let promptBtnAnimator = Easer5<CGPoint>.init(CGPoint.defaults, DefaultEasing.point){ point in
            disableAnim {
                promptBtn.layer?.position = point
            }
        }
        promptBtnAnimator.value = initPromptBtnRect.origin//set initial value
       
        /**
         * Event handling:
         */
        
//      var forceTouchMode:Int = 0//which level of forceTouch modal is currently in
        var modalStayMode:Bool = false//you can probably remove this and replace it with boundry check etc
        var leftMouseDraggedMonitor:Any?
        //var leftDraggedHandler:NSEventHandler?
        var onMouseDownMouseY:CGFloat = CGFloat.nan
        
//      var prevStage:Int = 0
        
        
        
        let forceTouchHandler = { (_ event:ForceTouchEvent) in
            //Swift.print("event.type: " + "\(event.type)")
            if event.type == ForceTouchEvent.clickDown{
                Swift.print("clickDown")
                modalAnimator.setTargetValue(clickModeRect).start()
            }else if event.type == ForceTouchEvent.deepClickDown{
                Swift.print("deepClickDown")
                modalAnimator.setTargetValue(modalRect).start()//Swift.print("window.contentView.localPos(): " + "\(window.contentView!.localPos())")
                onMouseDownMouseY  = self.window!.contentView!.localPos().y
                NSEvent.addMonitor(&leftMouseDraggedMonitor,.leftMouseDragged){_ in
                    let relativePos:CGFloat =  onMouseDownMouseY - self.window!.contentView!.localPos().y
                    //Swift.print("relativePos: " + "\(relativePos)")
                    var newRect = modalRect
                    newRect.y -= relativePos
                    modalAnimator.direct = true
                    modalAnimator.setTargetValue(newRect).start()
                    if modalAnimator.value.y < 30  {//modal in stayMode
                        modalStayMode = true
                        Swift.print("reveal buttons: \(modalAnimator.value.y)")
                        var p = modalAnimator.value.bottomLeft
                        p.y += 15//add some margin
                        p.y = p.y.max(maxPromptBtnPoint.y)
                        //
                        promptBtnAnimator.setTargetValue(p).start()//you could do modalBtn.layer.origin + getHeight etc.
                    }else if modalAnimator.value.y > 30 {//modal in leaveMode
                        modalStayMode = false
                        Swift.print("anim buttons out")
                        promptBtnAnimator.setTargetValue(initPromptBtnRect.origin).start() //anim bellow screen
                    }
                }
            }else if event.type == ForceTouchEvent.clickUp {
                Swift.print("clickUp")
                if !modalStayMode {//modal stay
                    modalAnimator.setTargetValue(initModalRect).start()
                }
                
            }else if event.type == ForceTouchEvent.deepClickUp {
                Swift.print("deepClickUp")
                if modalStayMode {//modal stay
                    Swift.print("modal stay")
                    modalBtn.removeHandler()
                    modalAnimator.direct = false
                    var rect = modalRect
                    rect.origin.y -= 30
                    modalAnimator.setTargetValue(rect).start()
                }else{//modal leave
                    Swift.print("modal leave")
                    modalAnimator.direct = false
                    modalAnimator.setTargetValue(initModalRect).start()

                    /*promptBtn*/
                    promptBtnAnimator.setTargetValue(initPromptBtnRect.origin).start() //anim bellow screen
                }
                NSEvent.removeMonitor(&leftMouseDraggedMonitor)
            }
            if event.type == ForceTouchEvent.stageChange {
                let stage:Int = event.stage
                Swift.print("stage: " + "\(stage)")
                if stage == 0 {
                    if !modalStayMode {
                        StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.blue)
                        Swift.print("override to blue")
                    }
                }else if stage == 1{
                    if !modalStayMode && event.prevStage == 0{ //only change to red if prev stage was 0
                        StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.red)
                        Swift.print("override to red")
                    }
                    
                }else /*if stage == 2*/{
                    if !modalStayMode {
                        StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.green)
                        Swift.print("override to green")
                    }
                    
                }
                //prevStage = stage
            }
            
            disableAnim {
                modalBtn.skin?.setStyle(style)
            }
        }
        
        modalBtn.addHandler(forceTouchHandler)
        
        /*handler for promptBtn*/
        promptBtn.addHandler(type:ButtonEvent.upInside) { (event:ButtonEvent) in
            Swift.print("promptBtn.upInside")
            modalAnimator.setTargetValue(initModalRect).start()/*outro modal*/
            promptBtnAnimator.setTargetValue(initPromptBtnRect.origin).start()/*outro promptBtn*/
            modalBtn.addHandler(forceTouchHandler)//reAdded forcetoucheventhandler, ideally add this handler on outro complete
            modalStayMode = false
        }
        
        
        //1. Add some design elements
            //create a concept in illustrator ✅
            //create other concepts in illustrator
            //get device templates
            //svg? 👈
            //setup proper TestView with class scoped var's etc 👈
                //use iphone7 screen ratio and window size 👈 (750 x 1334) (375 x 667) (200x355) ✅
                //Make design for demo2. stack of cards you can shuffle left and right etc (AppleWatch)
                //make design for demo3. basically just swipe left right cards and click to go to fullscreen (AppleTV)
    }
    
    
}
