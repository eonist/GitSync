import Foundation
import Cocoa

class TempWin:NSWindow, NSApplicationDelegate,NSTableViewDelegate{
    static var width = 700//Static variable, reachable on a class level
    static var height = 800
    var view:FlippedView = FlippedView(frame: NSRect(x: 0, y: 0, width: TempWin.width, height: TempWin.height))
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        let winRect = NSMakeRect(0, 0, NSScreen.mainScreen()!.frame.width/2, NSScreen.mainScreen()!.frame.height/2)

        super.init(contentRect: winRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        //let controller = NSWindowController(window: newWindow)
        //controller.showWindow(self)
        self.center()
        self.contentView = view
        self.title = "GitSync"
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
        
        //add,remove,info,view
        
        //figure out how to align buttons to view horizontally
        
        Swift.print("w: " + "\(self.frame.size.width)")
        Swift.print("h: " + "\(self.frame.size.height)")
        Swift.print("view w: " + "\(view.frame.size.width)")
        Swift.print("view h: " + "\(view.frame.size.height)")
        
        
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
        
        Swift.print("button w: " + "\(button.frame.width)")
        Swift.print("button h: " + "\(button.frame.height)")
        
    }
    /*
    * NSTableView
    */
    
    func createList(){
        let tableContainerRect:NSRect = NSRect(x: 120, y: 80, width: 500,height:300)//view.bounds
        let tableContainer = NSScrollView(frame: tableContainerRect)
        let tableView = TempTableView(frame: tableContainer.frame)//tableContainer.frame.width-100, height: tableContainer.frame.height
        self.makeFirstResponder(tableView)//focus tableView,doesnt work yet
        
        tableView.setDataSource(tableView)//set the datasource
        tableView.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable //TODO: try to get height working here to
        tableView.usesAlternatingRowBackgroundColors = true
        
        let columnA = NSTableColumn(identifier: "status")
        columnA.headerCell.title = "Status: "
        tableView.addTableColumn(columnA)
        
        let columnB = NSTableColumn(identifier: "remote-repo")
        columnB.headerCell.title = "Repository: "
        tableView.addTableColumn(columnB)
        
        let columnC = NSTableColumn(identifier: "branch")
        columnC.headerCell.title = "Branch: "
        tableView.addTableColumn(columnC)
        
        let columnD = NSTableColumn(identifier: "active")
        columnD.headerCell.title = "Active: "
        tableView.addTableColumn(columnD)
        
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
