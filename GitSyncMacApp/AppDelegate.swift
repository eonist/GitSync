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
        
        StyleManager.addStyle("#bg{fill:white;}")
        window.contentView?.addSubview(Section(window.size.w,window.size.h,nil,"bg"))
        

            //button
        
        StyleManager.addStyle("#btn{fill:white;}")
        let btn = window.contentView?.addSubView(Button(70,70,nil,"btn"))
        
        /*Ellipse*/
        let ellipse = EllipseGraphic(-50,-50,100,100,FillStyle(.blue),nil)
        window.contentView?.addSubview(ellipse.graphic)
        ellipse.draw()
        
        func progress(value:CGPoint){/*This method gets called 60FPS, add the values to be manipulated here*/
            disableAnim {/*Important so that you don't get the apple "auto" anim as well*/
                ellipse.graphic.layer?.position = value/*We manipulate the layer because it is GPU accelerated as oppose to setting the view.position which is slow*/
            }
        }
        let animator = PointEaser(progress, PointEaser.initValues,PointEaser.initConfig)/*Setup interuptable animator*/
        func onViewEvent(_ event:Event) {/*This is the click on window event handler*/
            if event.type == ButtonEvent.upInside {
                animator.targetValue = btn!.localPos()/*Set the position of where you want the anim to go*/
                if animator.stopped {animator.start()}/*We only need to start the animation if it has already stopped*/
            }
        }
        btn?.event = onViewEvent
            //event handler for deep press
        
        //2. hardpress button to activate pop
        
        //3. spring circular button into bigger square modal, centered
        
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
