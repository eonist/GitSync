import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - A really simple Git app")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css")
        win = MainWin(320,480)
        //Continue here: 
        //1. Setup the MainWin (White) (Fixed size: 320,480) (done)
            //2. Setup the TitleBar with GitSync name 
        //2. Setup bottom bar with Text buttons (Commits,Repos,Stats,Prefs)
        //3. Setup commit-list-view (show limit: 25 commits)
        //4. hock up "cmd + r" to refresh commit view (Freeze and jump to top)
        //5. Test with a demo repo
        //6. Setup A Tree-List to manage repos
        //7. Setup a TopBar that goes under the Titlebar with Add,Remove,Edit etc
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}