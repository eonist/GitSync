import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        StyleManager.addStylesByURL("~/Desktop/css/window.css")
        win = TranslucencyWin()//Win(1000,800)
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}






import Cocoa
/**
 * This is the main class for the application
 * TODO: create the window
 * TODO: the window has a view
 * TODO: the view has leftMenuView and MainView
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        var css = "Window{fill:#EFEFF4;corner-radius:4px;}"//E8E8E8//<--you should target a bg element not the window it self, since now everything inherits these values
        css += "}"
        //css += "Section{fill:#EFEFF4;corner-radius:4px 4px 0px 0px;}"
        //css += "Button{fill:green;}"
        css += ""
        StyleManager.addStyle(css)
        
        
        win = GitSyncWin(300,300)/*Init the window*/
        let app:NSApplication = aNotification.object as! NSApplication/*grab the app instance from the notification*/
        app.windows[0].close()/*close the initial non-optional default window*/
        
        
        
        
        /*
        let repoXML = FileParser.xml(repoFilePath.tildePath)
        let repoList = XMLParser.toArray(repoXML)
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        GitSync.initCommit(repoList[0], "master")

        
        GitSync.initPush(repoList[0], "master")
        
        */
        
        
        
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

/*
let appSupportPath = (NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask).first! as NSURL).path!
Swift.print("appSupportPath: " + "\(appSupportPath)")

let libraryPath = (NSFileManager.defaultManager().URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).first! as NSURL).path!

Swift.print("libraryPath: " + "\(libraryPath)")*/
