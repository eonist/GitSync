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
        //win.makeKeyWindow()
        //win.makeMainWindow()
        win.maxSize = NSSize(width: 900,height: 900)//sets the  max size of a window
        win.minSize = NSSize(width: 400,height: 400)//sets the  max size of a window
        win.becomeMainWindow()
        win.becomeKeyWindow()
        win.makeMainWindow()
        
        //win.orderFront(self)//ordering window:
        //win.orderBack(self)//ordering window:
        //win.center()//places the window in the center
        //win.setIsMiniaturized(false)
        //win.update()// Subclasses of NSWindow can override this method to examine the state of the application and change their own state or appearance accordingly-enabling or disabling menus, buttons, and other controls based on the object that's selected, for example.
        //win.setTitleWithRepresentedFilename("")// method formats a filename in the title bar in a readable format
        print(win.windowNumber)//window device a unique identifier (within an application). This is the window number
       
        //win.documentEdited = true //The method for marking this is setDocumentEdited:. When the window closes, its delegate can check it with isDocumentEdited to see whether the document needs to be saved.
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