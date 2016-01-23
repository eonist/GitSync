import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 * TODO: figure out how not to open the default window
 */
class AppDelegate: NSObject, NSApplicationDelegate{
    var win:NSWindow?// = WinUtils.win()
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //NSScreen.mainScreen()!.frame.width/2
        //NSScreen.mainScreen()!.frame.height/2
        Swift.print("applicationDidFinishLaunching")
        //let winRect = NSMakeRect(100, 0, 100, 100)//TODO: us ns rect?
        //let styleMask:Int = NSBorderlessWindowMask|NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
        //win = Win()
        win = Window(600,400)
        Swift.print("---")
        //self.win!.contentView!.wantsLayer = true
        //self.win.setContentView(self.newContentView)
        self.win!.makeKeyAndOrderFront(self)/*this may be need when using non borderless windows etc*/
        //win!.makeMainWindow()
        Swift.print(aNotification)
        let app:NSApplication = aNotification.object as! NSApplication
        app.windows[0].close()/*close the initial non-optional default window*/
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye")
    }
}

