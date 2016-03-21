import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        
        Swift.print("hello world")
        
        
        
        /*StyleManager.addStyle("Window{fill:white;corner-radius:4px;}")//E8E8E8//<--you should target a bg element not the window it self, since now everything inherits these values
        StyleManager.addStylesByURL("~/Desktop/css/gitsync.css")
        win = GitSyncWin(300,400)/*Init the window*/
        let app:NSApplication = aNotification.object as! NSApplication/*grab the app instance from the notification*/
        app.windows[0].close()/*close the initial non-optional default window*/*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}





/*
let repoXML = FileParser.xml(repoFilePath.tildePath)
let repoList = XMLParser.toArray(repoXML)
Swift.print("repoList.count: " + "\(repoList.count)")

GitSync.initCommit(repoList[0], "master")


GitSync.initPush(repoList[0], "master")

*/
        