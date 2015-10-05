import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow? //= NSWindow(contentRect: NSRect(x: 30, y: 30, width: 200, height: 200), styleMask: NSBorderlessWindowMask, backing: .Buffered, `defer`: false)
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let view = FlippedView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))
        window!.contentView = (view)//add the view directly to the window so that we can use the flipped view correctly

        let buttonX:Int = 0
        let buttonY:Int = 40//Int(window.frame.size.height)-30-20
        print("buttonY: " + String(buttonY))
        let button = NSButton(frame: NSRect(x: buttonX, y: buttonY, width: 100, height: 30))
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        
        //window.is
        
        view.addSubview(button)
        
        print("Hello world")
       // let theView:CustomView = CustomView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
        
        let textField = NSTextField(frame: NSRect(x: 0, y: 130, width: 100, height: 20))
        
        textField.stringValue = "Test"
        
        view.addSubview(textField)
        print("Hello world again")
        
        //let controller = NSWindowController(window: window)
        //controller.showWindow(self)
        
        
        let frame:NSRect = NSRect(x: 0, y: 0, width: 200, height: 200)
        window?.setFrame(frame, display: true)
        let x = NSScreen.mainScreen()!.visibleFrame.origin.x
        let y = NSScreen.mainScreen()!.visibleFrame.size.height//[[NSScreen mainScreen] visibleFrame].size.height
        
        window!.setFrameTopLeftPoint(NSMakePoint(x, y))
        
        //frame.size = theSizeYouWant;
      
        
        
        //window?.backgroundColor = NSColor.clearColor();
        //window?.opaque = false
        
        /*

        + [[NSScreen mainScreen] visibleFrame].size.width - [_window frame].size.width ;
        pos.y = [[NSScreen mainScreen] visibleFrame].origin.y + [[NSScreen mainScreen] visibleFrame].size.height - [_window frame].size.height  ;
        [_window setFrameOrigin : pos];
        
        */
            
            
        window?.title = "Test window: "//Setting the title of a window
        
        button.target = self
        button.action = "myAction:"
        
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
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



class FlippedView: NSView {
    override var flipped:Bool {
        get {
            return true
        }
    }
}
/*
class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var _window: NSWindow
    init(window: NSWindow) {
        self._window = window
    }
    func applicationDidFinishLaunching(notification: NSNotification?) {
        let webView = WebView(frame: self._window.contentView.frame)
        self._window.contentView.addSubview(webView)
        webView.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.google.com/ncr")))
    }
}
let applicationDelegate = ApplicationDelegate(window: window)

*/






class CustomView: NSView {
    override init(frame: NSRect) {
        super.init(frame: frame)
        
        antibez.moveToPoint(NSPoint(x: 10 , y: 10))
        /*
for i in 0..25{
            antibez.lineToPoint(NSPoint(x: 20 + 10 * (25-i), y: 20 + 10 * i))
            antibez.moveToPoint(NSPoint(x: 10 + 10 * (i), y: 10 ))
            
        }
*/
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(dirtyRect: NSRect) {
        color.setFill()
        NSRectFill(self.bounds)
        antibez.stroke()
        
    }
    
    var color = NSColor.greenColor()
    
    var antibez = NSBezierPath()
}
var view = CustomView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
