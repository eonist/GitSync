import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 */
class AppDelegate: NSObject, NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate {
    //MARK: - Properties
    //static var width = 400//Static variable, reachable on a class level
    //static var height = 600
    //var window: NSWindow?
    //var view:FlippedView = FlippedView(frame: NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height))
    //MARK: - Init
    var newWindow:NSWindow?// = WinUtils.win()
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        print("hello world")
        
        //view = FlippedView(frame: NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height))
        //window!.contentView = (view)
        //createButtons()
        //createTextField()
        //createList()
        createWindow()
        
        // init window.
        
        
        // let theView:CustomView = CustomView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
        
        /*
        let frame:NSRect = NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height)
        window?.setFrame(frame, display: true)//Resize the Window
        let x = NSScreen.mainScreen()!.visibleFrame.origin.x
        let y = NSScreen.mainScreen()!.visibleFrame.size.height//[[NSScreen mainScreen] visibleFrame].size.height

        window!.setFrameTopLeftPoint(NSMakePoint(x, y))//Moves the window in the computer screen
        window?.center()//aligns the window to the center of the screen
        
        window?.title = "Test window: "//Setting the title of a window
         */
    }
    /*
     * When the application closes
     */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        print("Good-bye world")
    }
    //MARK: - Create Content
  
   
    
    /*
    * Create window
    */
    func createWindow(){
        
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)
        newWindow = TempWin(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
       
    }
   
    
    //MARK: - Event handlers:
    func myAction(obj:AnyObject!){
        print("press")
        print(String(obj))
        print(classNameAsString(obj))
        print("My class is \((obj as! NSObject).className)")
    }
    func classNameAsString(obj: Any) -> String {
        print(String(obj))
        return _stdlib_getDemangledTypeName(obj).componentsSeparatedByString(".").last!
    }
}

