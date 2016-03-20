import Cocoa

//create the window
//the window has a view
//the view has leftMenuView and MainView

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //Swift.print("hello world")
        
        
        
        
        
        //.print("applicationDidFinishLaunching")
        /**/
        var css = ""//E8E8E8
        css += "Window Element#background{fill:#EFEFF4;corner-radius:4px;}"//<--you should target a bg element not the window it self, since now everything inherits these values
        //css += "Section{fill:#EFEFF4;corner-radius:4px 4px 0px 0px;}"
        //css += "Button{fill:green;}"
        css += ""
        StyleManager.addStyle(css)
        
        
        win = TranslucencyWin()//StashWin(300,300)//CustomWin(1000,800)/*CustomWin(300,300)*///TranslucencyWin()//TranslucentWin()////CustomWin(300,300)//Win()//Win()//TranslucentWin()//CustomWin(300,200)//Win()//CustomWin()/*Init the window*///Win()//TranslucentWin()
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
