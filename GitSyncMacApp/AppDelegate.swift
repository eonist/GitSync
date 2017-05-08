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
    //var fileWatcher:FileWatcher?
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Swift.print("GitSync - Automates git")//Simple git automation for macOS, The autonomouse git client,The future is automated
        //NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //initApp()
        //initTestWin()//🚧👷
        //initMinimalWin()
        hitTesting()
        //Continue here: 🏀
            //add general-direction-scrolling in ElasticScrollView 👈
            //figure out how to get hitTest working again
            //do some gui design
        
    }
    /**
     *
     */
    func hitTesting(){
        window.contentView = InteractiveView2()
        StyleManager.addStyle("Button{fill:blue;}")
        let btn = Button(100,50)
        let container = window.contentView!.addSubView(Container(0,0,nil))
        
        container.addSubview(btn)
        /*container.layer?.position.x = 100
         container.layer?.position.y = 100*/
        container.frame.origin = CGPoint(100,100)
        //container.frame.origin = CGPoint(100,100)
        Swift.print("container.layer?.position: " + "\(container.layer?.position)")
        Swift.print("container.frame.origin: " + "\(container.frame.origin)")
        btn.frame.origin = CGPoint(100,100)
        
        Swift.print("btn.layer?.position: " + "\(btn.layer?.position)")
        Swift.print("btn.frame.origin: " + "\(btn.frame.origin)")
        btn.event = { event in
            if(event.type == ButtonEvent.upInside){Swift.print("hello world")}
        }
        
        //Continue here:
            //I think you need to write a recursive method that traverse up the view hierarchy and find the relative P of the view (but also supports layer.position not just frame.origin)
            //try to roll back to a prev state where hittest worked with hit test
        
    }
    func initApp(){
         StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",false)//<--toggle this bool for live refresh
         win = MainWin(MainView.w,MainView.h)
         //win = ConflictDialogWin(380,400)
         //win = CommitDialogWin(400,356)
         //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
    }
    func initTestWin(){
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/test.css",false)
        win = TestWin(500,400)/*Debugging Different List components*/
        
        /*fileWatcher = */
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
    }
    func initMinimalWin(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/minimal.css",false)
        //Swift.print("StyleManager.styles.count: " + "\(StyleManager.styles.count)")
        //Swift.print("StyleManager.styles: " + "\(StyleManager.styles)")
        win = MinimalWin(500,400)
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        /*Stores the app prefs*/
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            _ = FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, PrefsView.xml.xmlString)
            Swift.print("💾 Write PrefsView to: prefs.xml")
        }
        Swift.print("💾 Write RepoList to: repo.xml")
        _ = FileModifier.write(RepoView.repoListFilePath.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        print("Good-bye")
    }
}
