import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

/**
 * This is the main class for the application
 * Not one error in a million keystrokes
 */
@NSApplicationMain
class AppDelegate:NSObject, NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var menu:Menu?//TODO: ⚠️️ make lazy. does it need to be scoped globally?
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Swift.print("GitSync - Automates git")//Simple git automation for macOS, The autonomouse git client,The future is automated
        //initApp()
        
        //Continue here: 🏀 
            //try with out disableAnim
            //Add more types to Easer/Springer
            //try to do a rotation test back and forth with elastic
            //Playground testing
        //add interuptabable animators to the fold
        
        peekAndPopTest()
    }
    /**
     * It's all about making bespoke interactions 👌
     */
    func peekAndPopTest(){
        //1. circular button,centered
            //window
        let winRect = CGRect(0,0,200,300)
        window.size = winRect.size
        window.contentView = InteractiveView2()
        window.title = ""
        
        StyleManager.addStyle("#bg{fill:white;padding-top:24px;}")
        let section = window.contentView?.addSubView(Section(window.size.w,window.size.h,nil,"bg"))
        
        let initFillet:CGFloat = 20
        
        let initRect:CGRect = {
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        let clickModeRect:CGRect = {
            let size:CGSize = initRect.size * 0.75
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        let modalRect:CGRect = {
            let size = CGSize(winRect.size.w,winRect.size.w) - CGSize(40,0)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        //let modalFillet:CGFloat = initFillet * 2
        
        let btn:Button = {//button
            StyleManager.addStyle("Button{width:\(initRect.size.w)px;height:\(initRect.size.h)px;fill:blue;corner-radius:20px;clear:none;float:none;}")
            let btn = window.contentView!.addSubView(ForceTouchButton(initRect.size.w,initRect.size.h,nil,"btn"))
            btn.point = initRect.origin//center button
            return btn
        }()
        
        var style:Style = btn.skin!.style! as! Style
        
        var animator = Easer5<CGRect>(CGRect.defaults, DefaultEasing.rect) { (rect:CGRect) in
            //anim rect here buttonRect to modalRect
            //Swift.print("rect: " + "\(rect)")
            disableAnim {
                StyleModifier.overrideStylePropVal(&style, ("width",0), rect.size.w)
                StyleModifier.overrideStylePropVal(&style, ("height",0), rect.size.h)
                btn.skin?.setStyle(style)
                btn.layer?.position = rect.origin
            }
        }
        animator.state.value = initRect
        var modalState:Int = 0
        var leftMouseDraggedEventListener:Any?
        var onMouseDownMouseY:CGFloat = CGFloat.nan
        
//        var prevStage:Int = 0
        func onViewEvent(_ event:Event) {/*This is the click on window event handler*/
            if let event = event as? ForceTouchEvent {
                onTouchEvent(event)
            }/*else if let event = event as? MouseEvent, event.type == MouseEvent.move{
                 Swift.print("section.localPos(): " + "\(section!.localPos())")
                 Swift.print("btn.localPos(): " + "\(btn.localPos())")
             }*/else{
                Swift.print("event.type: " + "\(event.type)")
            }
        }
        func onModalDrag(event:NSEvent)-> NSEvent?{
            let leaverPos:CGFloat = -btn.localPos().y + onMouseDownMouseY
            Swift.print("leaverPos: " + "\(leaverPos)")
            return event
        }
        /**
         *
         */
        func onTouchEvent(_ event:ForceTouchEvent){
            //Swift.print("event.type: " + "\(event.type)")
            if event.type == ForceTouchEvent.clickDown{
                Swift.print("clickDown")
                animator.state.targetValue = clickModeRect
                animator.onComplete = {modalState = 1}
                animator.start()
            }else if event.type == ForceTouchEvent.deepClickDown{
                Swift.print("deepClickDown")
                animator.state.targetValue = modalRect
                animator.onComplete = {modalState = 2}
                animator.start()
                Swift.print("window.contentView.localPos(): " + "\(window.contentView!.localPos())")
                onMouseDownMouseY  = btn.localPos().y
                if(leftMouseDraggedEventListener == nil) {leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDragged], handler: onModalDrag)}//we add a global mouse move event listener
                else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
            }else if event.type == ForceTouchEvent.clickUp {
                Swift.print("clickUp")
                animator.state.targetValue = initRect
                animator.onComplete = {modalState = 0}
                animator.start()
            }else if event.type == ForceTouchEvent.deepClickUp {
                Swift.print("deepClickUp")
                animator.state.targetValue = initRect
                animator.onComplete = {modalState = 1}
                animator.start()
                if(leftMouseDraggedEventListener != nil){
                    NSEvent.removeMonitor(leftMouseDraggedEventListener!)
                    leftMouseDraggedEventListener = nil//<--this part may not be needed
                }/*We remove a global mouse move event listener*/
            }
            if event.type == ForceTouchEvent.stageChange {
                let stage:Int = event.stage
                Swift.print("stage: " + "\(stage)")
                if stage == 0 {
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.blue)
                    Swift.print("override to blue")
                    
                }else if stage == 1{
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.red)
                    Swift.print("override to red")
                    
                }else /*if stage == 2*/{
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.green)
                    Swift.print("override to green")
                }
                //prevStage = stage
            }
            
            disableAnim {
                btn.skin?.setStyle(style)
            }
        }
        
        btn.addHandler(onViewEvent)
        //btn.event = {event in if let event = event as? ForceTouchEvent {onViewEvent(event)}}
            //event handler for deep press
        
        //2. hardpress button to activate pop ✅
            //When hardpress state is lost then Ease to circular button again ✅
        
        
        //3. ease circular button into bigger square modal, centered ✅
            //add support for CGSize and CGRect in Animator ✅
            //setup modalIdleRect /*basically when modal is in idle state */ ✅
        
        //4. spring modal in the .y axis to your mouse.position, offset by center 👈
            //you need to get the window.pos and calc the offset on this, as the modal will move
            //do regular direct moving first
            //write an extension to simplify adding dragListener
            //then do spring
            //then apply some log10 slipperyFriction
        
        //5. when modal.bottom moves beyond a threshold, spring in button bellow modal (you may need to dto the relational spring test first)
        
        //6. when button release in peek mode, transition modal to button
        
        //7. when button release in input mode, dont transition anything
        
        //8. when user clicks the button bellow modal, transition modal to circular button and spring inputButton bellow screen
    }
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
        
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        let rect:CGRect = PrefsView.prefs.rect
        win = StyleTestWin(rect.w, rect.h)/*⬅️️🚪*/
        menu = Menu()/*This creates the App menu*/
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.prefs.tildePath, PrefsView.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.repoListFilePath.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}
