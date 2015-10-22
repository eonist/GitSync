import Foundation
import Cocoa
class WinUtils {
    /*
     * Creates a basic window
     */
    class func win()->NSWindow{
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)
        let newWindow = NSWindow(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        newWindow.title = "New Window"
        newWindow.opaque = false
        
        newWindow.hasShadow = true
        newWindow.center()//moves the window to the center
        newWindow.movableByWindowBackground = true
        newWindow.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
        newWindow.makeKeyAndOrderFront(nil)
        return newWindow
    }
}