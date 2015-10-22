import Foundation
import Cocoa
class WinUtils {
    /*
     * Creates a basic window
     */
    class func win()->NSWindow{
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)
        let win = NSWindow(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        win.title = "New Window"
        win.opaque = false
        //win = NSBorderlessWindowMask
        win.hasShadow = true
        win.center()//moves the window to the center
        win.movableByWindowBackground = true
        win.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
        win.makeKeyAndOrderFront(nil)
        //win.center()//places the window in the center
        //win.setIsMiniaturized(false)
        //win.setTitleWithRepresentedFilename("")// method formats a filename in the title bar in a readable format
        return win
    }
    
    /**
    * BETA
    */
    class func removeAllSubViews(window:NSWindow){
        let views:Array<NSView> = (window.contentView?.subviews)!
        for view:NSView in views{
            view.removeFromSuperview()
        }
    }
}