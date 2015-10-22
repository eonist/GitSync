import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 */
class AppDelegate: NSObject, NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate {
    var newWindow:NSWindow?// = WinUtils.win()
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        print("hello world")
        
      
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)
        newWindow = TempWin(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        
        
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye world")
    }
    //MARK: - Create Content
  

    
    
}

