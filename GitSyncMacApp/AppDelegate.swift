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
        
        let textCSS:String = "Text{margin-top:0px;float:left;clear:left;font:Helvetica Neue;size:18px;align:center;type:dynamic;color:grey6;selectable:true;wordWrap:true;}"
        StyleManager.addStyle(textCSS)
        
        let text = Text(200,24,"0.0",section,"pressureText")
        section?.addSubview(text)
        
        let text2 = Text(200,24,"idle",section,"stageText")
        section?.addSubview(text2)

        
        
        
        
        let initRect:CGRect = {
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        let initFillet:CGFloat = 20
        
        let minRect:CGRect = {
            let size = initRect.size * 0.5
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        let minFillet:CGFloat = initFillet * 0.5
        
        let btn:Button = {//button
            StyleManager.addStyle("Button{width:\(initRect.size.w)px;height:\(initRect.size.h)px;fill:blue;corner-radius:20px;clear:none;float:none;}")
            let btn = window.contentView!.addSubView(ForceTouchButton(initRect.size.w,initRect.size.h,nil,"btn"))
            btn.point = initRect.origin//center button
            return btn
        }()
        
        var style:Style = btn.skin!.style! as! Style
        
        func onViewEvent(_ event:Event) {/*This is the click on window event handler*/
            if event.type == ForceTouchEvent.clickDown{
                Swift.print("clickDown")
            }else if event.type == ForceTouchEvent.deepClickDown{
                Swift.print("deepClickDown")
                //continue here:
                    //make Easer5
            }else if event.type == ForceTouchEvent.clickUp {
                Swift.print("clickUp")
            }else if event.type == ForceTouchEvent.deepClickUp {
                Swift.print("deepClickUp")
            }
            if event.type == ForceTouchEvent.stageChange {
                let stage:Int = (event as! ForceTouchEvent).stage
                Swift.print("stage: " + "\(stage)")
                if stage == 0 {
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.blue)
                    Swift.print("override to blue")
                    text2.setText("idle")
                }else if stage == 1{
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.red)
                    Swift.print("override to red")
                    text2.setText("click")
                }else /*if stage == 2*/{
                    StyleModifier.overrideStylePropVal(&style, ("fill",0), NSColor.green)
                    Swift.print("override to green")
                    text2.setText("deep click")
                }
            }
            
            
        }
        
        
        btn.event = onViewEvent
            //event handler for deep press
        
        //2. hardpress button to activate pop ✅
            //When hardpress state is lost then Ease to circular button again
        
        
        //3. ease circular button into bigger square modal, centered
            //add support for CGSize and CGRect in Animator
            //setup modalIdleRect /*basically when modal is in idle state */
        
        //4. spring modal in the .y axis to your mouse.position, offset by center
        
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
