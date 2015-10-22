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
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)//TODO: us ns rect?
        win = TempWin(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        //self.win.setContentView(self.newContentView)
        self.win!.makeKeyAndOrderFront(self)
        win!.makeMainWindow()
        
        //print(aNotification)
        let app:NSApplication = aNotification.object as! NSApplication
        print(app)
        print(app.mainWindow)
        print(app.keyWindow)
        for w in app.windows{
            print("windowNumber: " + "\(w.windowNumber)")
            //app.windowWithWindowNumber(<#T##windowNum: Int##Int#>)//this is how you can manage windows
        }
        app.windows[0].close()//close the initial window
        //app.windows[1].close()//close the initial window
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye")
    }
    
}

