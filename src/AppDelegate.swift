import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 * TODO: figure out how not to open the default window
 */
class AppDelegate: NSObject, NSApplicationDelegate{
    var window:NSWindow?// = WinUtils.win()
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)//TODO: us ns rect?
        window = TempWin(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye")
    }
}

