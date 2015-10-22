import Foundation
import Cocoa

class TempWin:NSWindow, NSApplicationDelegate,NSTableViewDelegate{
    static var width = 800//Static variable, reachable on a class level
    static var height = 600
    static var sizeRect:NSRect = NSRect(x: 0, y: 0, width: TempWin.width, height: TempWin.height)//NSMakeRect(0, 0, TempWin.width, TempWin.height)
    var view:FlippedView = FlippedView(frame: TempWin.sizeRect)
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: TempWin.sizeRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        //let controller = NSWindowController(window: newWindow)
        //controller.showWindow(self)
        self.center()
        self.contentView = view
        self.title = "GitSync"
        createContent()
    }
    /*
    * Required by the NSWindow
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
    *
    */
    func createContent(){ 
        createButtons()
        //createTextField()
        createTable()
    }
    /*
    *
    */
    func createButtons(){
        
        //
        
        //figure out how to align buttons to view horizontally
        
        Swift.print("NSScreen.mainScreen()!.frame.width: " + "\(NSScreen.mainScreen()!.frame.width)")
        Swift.print("NSScreen.mainScreen()!.frame.height: " + "\(NSScreen.mainScreen()!.frame.height)")
        
        Swift.print("self.frame.size.width: " + "\(self.frame.size.width)")
        Swift.print("self.frame.size.height : " + "\(self.frame.size.height)")
        Swift.print("view.frame.size.width: " + "\(view.frame.size.width)")
        Swift.print("view.frame.size.height: " + "\(view.frame.size.height)")
        
        let buttonWidth:Int = 100
        //let buttonX:Int = (TempWin.width/2) - (buttonWidth/2)
        
        let topPadding:Int = 24
        let buttonSpacing:Int = 12
        //let buttonY:Int = topPadding//Int(window.frame.size.height)-30-20
        //print("buttonY: " + String(buttonY))
        
        //Swift.print("button.frame.width: " + "\(button.frame.width)")
        //Swift.print("button.frame.height: " + "\(button.frame.height)")
        
        let buttonTitles:[String] = ["Add","Remove","Info","View"]
        var buttons:Array<NSButton> = []
        for buttonTitle:String in buttonTitles{
            //Swift.print(buttonTitle)
            let button = NSButton(frame: NSRect(x: 0, y: 0, width: buttonWidth, height: 30))
            button.title = buttonTitle
            //button.highlight(true)
            let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
            buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
            
            view.addSubview(button)//Add button to view
            button.target = self
            button.action = "myAction:"//
            buttons.append(button)
        }
        
        //TODO: try to add and remove items from the Table
        
        Align.horizontal(buttons,TempWin.width,topPadding,buttonSpacing)
    }
    /*
    * NSTableView
    */
    
    func createTable(){
        let tableWidth:Int = 500
        let tablePosX:Int = (TempWin.width/2) - (tableWidth/2)
        let tableContainerRect:NSRect = NSRect(x: tablePosX, y: 80, width: 500,height:300)//view.bounds
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
