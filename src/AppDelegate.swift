import Cocoa
import Foundation

@NSApplicationMain/*<-required by the application*/
/*
 * The class for the application
 */
class AppDelegate: NSObject, NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate {
    //MARK: - Properties
    static var width = 400//Static variable, reachable on a class level
    static var height = 600
    var window: NSWindow? //= NSWindow(contentRect: NSRect(x: 30, y: 30, width: 200, height: 200), styleMask: NSBorderlessWindowMask, backing: .Buffered, `defer`: false)
    var view:FlippedView = FlippedView(frame: NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height))
    //MARK: - Init
    /**
     * Initializes your application
     */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        view = FlippedView(frame: NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height))
        window!.contentView = (view)
        //createButtons()
        //createTextField()
        createList()
        
        // let theView:CustomView = CustomView(frame:NSRect(x: 0, y: 0, width: 300, height: 300))
        
        let frame:NSRect = NSRect(x: 0, y: 0, width: AppDelegate.width, height: AppDelegate.height)
        window?.setFrame(frame, display: true)//Resize the Window
        let x = NSScreen.mainScreen()!.visibleFrame.origin.x
        let y = NSScreen.mainScreen()!.visibleFrame.size.height//[[NSScreen mainScreen] visibleFrame].size.height
        
        window!.setFrameTopLeftPoint(NSMakePoint(x, y))//Moves the window in the computer screen
        window?.title = "Test window: "//Setting the title of a window
    }
    //MARK: - Create Content
    /*
     * NSButton
     */
    func createButtons(){
        let buttonX:Int = 0
        let buttonY:Int = 40//Int(window.frame.size.height)-30-20
        print("buttonY: " + String(buttonY))
        let button = NSButton(frame: NSRect(x: buttonX, y: buttonY, width: 100, height: 30))
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        
        view.addSubview(button)//Add button to view
        button.target = self
        button.action = "myAction:"
    }
    /*
     * NSTextField
     */
    func createTextField(){
        let textField = NSTextField(frame: NSRect(x: 0, y: 130, width: 100, height: 20))
        textField.stringValue = "Test"
        view.addSubview(textField)
        print("Hello world again")
    }
    /*
     * NSTableView
     */
    func createList(){
        let tableContainerRect:NSRect = NSRect(x: 20, y: 20, width: 300,height:400)//view.bounds
        let tableContainer = NSScrollView(frame: tableContainerRect)
        let tableView = CustomTableView(frame: tableContainer.frame)//tableContainer.frame.width-100, height: tableContainer.frame.height
        
        tableView.setDataSource(tableView)//set the datasource
        tableView.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable //TODO: try to get height working here to
        tableView.usesAlternatingRowBackgroundColors = true
        let column = NSTableColumn(identifier: "1")
        column.headerCell.title = "Header Title here"
        tableView.addTableColumn(column)

        tableView.setDelegate(self)//listen for delagation events
        tableContainer.documentView = tableView
        tableContainer.hasVerticalScroller = true
        view.addSubview(tableContainer)//add to the view
    }
    /*
     * When the application closes
     */
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

