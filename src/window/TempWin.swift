import Foundation
import Cocoa

class TempWin:NSWindow, NSApplicationDelegate,NSTableViewDelegate{
    static var width = 400//Static variable, reachable on a class level
    static var height = 600
    var view:FlippedView = FlippedView(frame: NSRect(x: 0, y: 0, width: TempWin.width, height: TempWin.height))
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)

        super.init(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        //let controller = NSWindowController(window: newWindow)
        //controller.showWindow(self)
        self.center()
        self.contentView = view
        self.title = "Temp window"
        createContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
    *
    */
    func createContent(){ 
        createButtons()
        createTextField()
        createList()
    }
    /*
    *
    */
    func createButtons(){
        let buttonX:Int = 0
        let buttonY:Int = 40//Int(window.frame.size.height)-30-20
        //print("buttonY: " + String(buttonY))
        let button = NSButton(frame: NSRect(x: buttonX, y: buttonY, width: 100, height: 30))
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        
        view.addSubview(button)//Add button to view
        button.target = self
        button.action = "myAction:"
    }
    /*
    * NSTableView
    */
    
    func createList(){
        let tableContainerRect:NSRect = NSRect(x: 220, y: 20, width: 300,height:400)//view.bounds
        let tableContainer = NSScrollView(frame: tableContainerRect)
        let tableView = TempTableView(frame: tableContainer.frame)//tableContainer.frame.width-100, height: tableContainer.frame.height
        self.makeFirstResponder(tableView)//focus tableView,doesnt work yet
        
        tableView.setDataSource(tableView)//set the datasource
        tableView.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable //TODO: try to get height working here to
        tableView.usesAlternatingRowBackgroundColors = true
        let column = NSTableColumn(identifier: "1")
        column.headerCell.title = "Month names"
        tableView.addTableColumn(column)
        
        tableView.setDelegate(self)//listen for delagation events
        tableContainer.documentView = tableView
        tableContainer.hasVerticalScroller = true
        view.addSubview(tableContainer)//add to the view
    }
    
    /*
    * NSTextField
    */
    func createTextField(){
        let textField = NSTextField(frame: NSRect(x: 0, y: 130, width: 100, height: 20))
        textField.stringValue = "Test"
        view.addSubview(textField)
        //print("Hello world again")
    }
    func myAction(obj:AnyObject!){
        Swift.print(classNameAsString(obj))
        Swift.print("My class is \((obj as! NSObject).className)")
    }
    func classNameAsString(obj: Any) -> String {
        Swift.print(String(obj))
        return _stdlib_getDemangledTypeName(obj).componentsSeparatedByString(".").last!
    }
}
