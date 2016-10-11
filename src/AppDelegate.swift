import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide the interface when the mouse is not over the app (anim in and out)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - A really simple Git app")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",false)//<--toggle this bool for live refresh
        
        win = MainWin(MainView.w,MainView.h)
        
        let url:String = "~/Desktop/ElCapitan/gitsync.css"
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                Swift.print("update to the file happened")
                StyleManager.addStylesByURL(url,true)
                let view:NSView = self.win!.contentView!
                ElementModifier.refreshSkin(view as! IElement)
                ElementModifier.floatChildren(view)
            }
        }
        fileWatcher!.start()
        
        //Continue here: 
        //1. Setup the MainWin (White) (Fixed size: 320,480) (done)
            //Test Live-Reload and try and make a Night mode version
        //2. Setup the TitleBar with GitSync name (add some vertical space around the titleBar buttons) (done)
        //2. Setup bottom bar with Text buttons (Commits,Repos,Stats,Prefs)
            //overrirde on win resize, in Window and add auto align to the MenuView
            //add some font awesome icons as .svg
        //3. Setup commit-list-view (show limit: 25 commits)
            //Check the legacy code
            //Try to make it work
        //4. hock up "cmd + r" to refresh commit view (also via app menu) (Freeze and jump to top)
            //setup app menu
        //5. Test with a demo repo
        //6. Setup A Tree-List to manage repos
            //install other and advance styles a single css files (done)
            //Setup a way to Navigate between the different views. See legacy code (done)
            //Setup Master - Detail view for RepoView
            //Setup TopBar with Add/Remove/Edit Buttons
        //7. Setup a TopBar that goes under the Titlebar with Add,Remove,Edit etc
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}