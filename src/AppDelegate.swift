import Cocoa
@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 */
class AppDelegate: NSObject, NSApplicationDelegate{
    var win:NSWindow?// = WinUtils.win()
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //.print("applicationDidFinishLaunching")
        var css = ""
        css += "Window{fill:#EFEFF4;corner-radius:4px;}"
        css += "Section{fill:yellow;}"
        css += "Button{fill:green;}"
        css += ""
        StyleManager.addStyle(css)
        win = CustomWin()/*Init the window*///Win()
        let app:NSApplication = aNotification.object as! NSApplication/*grab the app instance from the notification*/
        app.windows[0].close()/*close the initial non-optional default window*/
    }
    /*
     * When the application closes
     * NOTE: Insert code here to tear down your application
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}

