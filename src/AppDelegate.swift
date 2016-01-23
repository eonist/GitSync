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
        self.win!.makeKeyAndOrderFront(self)
        //win!.makeMainWindow()
        //print(aNotification)
        let app:NSApplication = aNotification.object as! NSApplication
        //print(app)
        print(app.mainWindow)
        //print(app.keyWindow)
        
        for w in app.windows{
            print("windowNumber: " + "\(w.windowNumber)")
            app.windowWithWindowNumber(w.windowNumber)//this is how you can manage windows
        }
        /**/
        Swift.print("app.windows.count: " + "\(app.windows.count)")
        //app.windows[0].close()//close the initial window
        //app.windows[1].close()//close the initial window
        Swift.print("after close")
        Swift.print("app.windows.count: " + "\(app.windows.count)")
        for w in app.windows{
            print("windowNumber: " + "\(w.windowNumber)")
            app.windowWithWindowNumber(w.windowNumber)//this is how you can manage windows
        }
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye")
    }
}

