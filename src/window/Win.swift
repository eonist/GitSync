import Foundation
import Cocoa

/*
* NOTE: Great doc about NSWin: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindow_Class/
* TODO: Add Broadcast/Subscribe to info win
* TODO: Add Transmit/Receive buttons to tab-bar
*/
class Win:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    static var topPadding = 12//make this into a tuple or enum or struct or or
    static var leftPadding = 12
    let titles:[String] = ["Add","Remove"]//,"Info","View","test"
    //add a row of debug buttons bellow the tableview
    static var width = 200//Static variable, reachable on a class level
    static var height = 200
    static var sizeRect:NSRect = NSRect(x: 100, y: 100, width: Win.width, height: Win.height)//NSMakeRect(0, 0, TempWin.width, TempWin.height)
    //todo you could add the bellow as lazy?
    //lazy var view = WinView(frame: Win.sizeRect)//WinViewTest(frame: Win.sizeRect)//,FlippedView(frame: Win.sizeRect)
    lazy var view = WinView4(frame: Win.sizeRect)/*<--This is the main view for this Window*/
    override public var canBecomeKeyWindow:Bool {return true}/*Custom windows that use the NSBorderlessWindowMask can't become key by default. Override this method so that controls in this window will be enabled.*/
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        let styleMask:Int = NSResizableWindowMask|NSBorderlessWindowMask//NSBorderlessWindowMask/*NSBorderlessWindowMask*///NSTitledWindowMask/*A title bar*/|NSResizableWindowMask/*A resize bar, border, or box*/|NSMiniaturizableWindowMask/*A miniaturize button*/|NSClosableWindowMask/*A close button*/
        super.init(contentRect: Win.sizeRect, styleMask: styleMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        //
        self.contentView!.wantsLayer = true;
        self.backgroundColor = NSColor.orangeColor()
        //self.opaque = true/*true == transperant*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        self.movableByWindowBackground = true
        //self.makeKeyWindow()
        //self.makeMainWindow()
        //Swift.print(self.deviceDescription)
        //self.hasShadow = false
        //self.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)

        
        //win.setIsMiniaturized(false)
        //Swift.print(self.windowNumber)
        //Swift.print(self.screen?.deviceDescription)
        //Swift.print(self.screen!.frame)//screen size
        //Swift.print(self.frame)//frame size
        //Swift.print(view.bounds)
        //let controller = NSWindowController(window: newWindow)
        //controller.showWindow(self)
        //self.center()
        //view.wantsLayer = true;
        self.contentView = view
        
        self.title = ""//GitSync
        createContent()
        self.delegate = self
        
    }
    
    /*
     * Required by the NSWindow
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     * I think this serves as a block for closing, i. promt the user to save etc
     */
    func windowShouldClose(sender: AnyObject) -> Bool {
        Swift.print("windowShouldClose")
        return true
    }
    /**
     *
     */
    func createContent(){
        

        
        //testElement()
        //createStyles()
        //createElement()
        //createTextField()
        //createTable()
        //createButtons()
        //createPanel()
    }

    
    /**
     *
     */
    func testElement(){
        /*
        let section = Section(500,500)
        let subSection = Section(500,500,section)
        let element = Element(400,400,subSection)
        //view.addSubview(element)
        //let parents = ElementParser.parents(element)
        let querrySelectors:Array = ElementParser.selectors(element);// :TODO: possibly move up in scope for optimizing
        Swift.print("querrySelectors.count: " + "\(querrySelectors.count)")
        Swift.print("STACK: " + SelectorParser.string(querrySelectors));
        
        //Swift.print("parents.count: " + "\(parents.count)")
        
        */
        
        
        
        //continue here: Try to implement skins and try to make some GUI items with skins and cool design
        
        
        
        
        
    }
    /**
     *
     */
    func createStyles(){
        //"Button{fill:red;} CheckButton{line:blue;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection("Section[Button,Slider]Arrow{fill:red;}")
        Swift.print("styleCollection.styles.count: " + "\(styleCollection.styles.count)")
        StyleCollectionParser.describe(styleCollection)
        
    }
    /**
    *
    */
    func createElement(){
        //let buttonStyle:IStyle = Style("buttonStyle",[StyleProperty("idleColor",0xFF0000),StyleProperty("overColor",0x0000FF)])
        //Swift.print(buttonStyle.name)
        
        
        //gradientStyle
        /*
        let idleStyle2Selctor:ISelector = Selector("Element",[],"",[SkinStates.none])
        let idleStyle2:IStyle = Style("idleStyle2",[],idleStyle2Selctor)
        idleStyle2.addStyleProperty(StyleProperty("fillGradientColorA", Colors.lightGray))
        idleStyle2.addStyleProperty(StyleProperty("fillGradientColorB", Colors.purple))
        idleStyle2.addStyleProperty(StyleProperty("lineWidth", 12))
        idleStyle2.addStyleProperty(StyleProperty("lineColor", Colors.lightGray))
        idleStyle2.addStyleProperty(StyleProperty("lineAlpha", 1.0))
        StyleManager.addStyle(idleStyle2)
        */
        //idle style:
        /**
         *
         */
       
        let idleStyleSelector:ISelector = Selector("Element",[],"",[SkinStates.none])
        let idleStyle:IStyle = Style("idleStyle",[idleStyleSelector],[])
        idleStyle.addStyleProperty(StyleProperty("fillColor", Colors.PURPLE))
        idleStyle.addStyleProperty(StyleProperty("fillAlpha", 1.0))
        idleStyle.addStyleProperty(StyleProperty("lineColor", Colors.LIGHTGRAY))
        idleStyle.addStyleProperty(StyleProperty("lineAlpha", 1.0))
        idleStyle.addStyleProperty(StyleProperty("lineWidth", 12))
        StyleManager.addStyle(idleStyle)
         /**/
        //down style:
        
        let downStyleSelector:ISelector = Selector("Element",[],"",[SkinStates.down])
        let downStyle:IStyle = Style("downStyle",[downStyleSelector],[])
        downStyle.addStyleProperty(StyleProperty("fillColor", Colors.LIGHTBLUE))
        downStyle.addStyleProperty(StyleProperty("fillAlpha", 1.0))
        downStyle.addStyleProperty(StyleProperty("lineColor", Colors.DARKGRAY))
        downStyle.addStyleProperty(StyleProperty("lineAlpha", 1.0))
        downStyle.addStyleProperty(StyleProperty("lineWidth", 5))
        StyleManager.addStyle(downStyle)
        /**/
        
         /*
        //idle
        let buttonIdleSelector:ISelector = Selector("Button",[],"",[SkinStates.none])
        var buttonIdleStyle:IStyle = Style("buttonIdleStyle",[], buttonIdleSelector)
        buttonIdleStyle = StyleModifier.clone(idleStyle,"buttonIdleStyle")
        StyleModifier.overrideStyleProperty(&buttonIdleStyle, StyleProperty("fillColor", Colors.orange))
        StyleModifier.overrideStyleProperty(&buttonIdleStyle, StyleProperty("lineColor", Colors.red))
        StyleManager.addStyle(buttonIdleStyle)
        //down
        let buttonDownSelector:ISelector = Selector("Button",[],"",[SkinStates.down])
        var buttonDownStyle:IStyle = Style("buttonDownStyle",[], buttonDownSelector)
        buttonDownStyle = StyleModifier.clone(downStyle,"buttonDownStyle")
        StyleModifier.overrideStyleProperty(&buttonDownStyle, StyleProperty("downLineColor", Colors.darkGray))
        StyleModifier.overrideStyleProperty(&buttonDownStyle, StyleProperty("downFillColor", Colors.lightBlue))
        */
        
        
       
        //button
        
        /*
        var idleButtonStyle:IStyle = Style("idleButtonStyle",[Selector("Button")],[StyleProperty("fillcolor", Colors.green)])
        idleButtonStyle.addStyleProperty(StyleProperty("fillGradientColorA", Colors.lightGray))
        idleButtonStyle.addStyleProperty(StyleProperty("fillGradientColorB", Colors.purple))
        StyleModifier.merge(&idleButtonStyle, idleStyle)
        StyleManager.addStyle(idleButtonStyle)
        var downButtonStyle:IStyle = Style("downButtonStyle",[Selector("Button",[],"",["down"])],[StyleProperty("fillcolor", Colors.yellow)])
        downButtonStyle.addStyleProperty(StyleProperty("fillGradientColorA", Colors.orange))
        downButtonStyle.addStyleProperty(StyleProperty("fillGradientColorB", Colors.lightGray))
        StyleModifier.merge(&downButtonStyle, downStyle)
        StyleManager.addStyle(downButtonStyle)
        
         */
        
        //Swift.print(StyleManager.getStyle("element")!.name)
        
        
        /*
        let element = Element(400,400)
        element.skinState = SkinStates.none//SkinStates.down
        view.addSubview(element)//it seems NSViews arent drawn until they are added to a subview. interesting
        */
        
        
        
        
        
        /*
        let button = Button(100,36)//"Browse",
        view.addSubview(button)//Add button to view
        */
        
        //button.frame.origin.x = element.frame.origin.x + element.frame.width +  12
        
    }
    /*
    *
    */
    func createButtons(){
        /*
        var buttons:Array<NSButton> = []
        
        //TODO: store buttons globaly, and switch in the myaction call
        //TODO: create a view named container with buttons that the tableview then can pin itself to
        //TODO: create debug button so you can test how to get the table row id of the selected row
        
        //create a custom button class that overides the drawing , the style it however you like. hover, press etc (Try that DrawCode app maybe?)
        for title:String in titles{
            
            let button = Create.simpleTextButton(title)
            view.addSubview(button)//Add button to view
            
            button.target = self//event dispataches to this instance
            button.action = "myAction:"//event dispatches to this method
            buttons.append(button)//add button to button list

        }
        let x = Table.leftPadding
        let y = Win.height - Win.topPadding - EditMenu.height + EditMenu.topPadding + 12//<- the last one could be the header taking up space or or?
        Align.horizontally(buttons,"left",Win.width,x,y,EditMenu.spacing)//aligns the buttons
        */
    }
    /**
    *
    */
    func createPanel(){
        /*
        let panel = Panel()
        view.addSubview(panel)
        */
    }
    /*
    * NSTableView
    */
    func createTable(){
        let tableContainerRect:NSRect = NSRect(x: Table.leftPadding, y: Win.topPadding, width: Table.width-Table.leftPadding,height:Win.height-Win.topPadding-EditMenu.height)//view.bounds
        let tableContainer = NSScrollView(frame: tableContainerRect)
        tableContainer.drawsBackground = true;
        tableContainer.backgroundColor = NSColor.blueColor()
        tableContainer.borderType = NSBorderType.NoBorder//NSBorderType.BezelBorder
        let table = Table()//tableContainer.frame.width-100, height: tableContainer.frame.height
        //self.makeFirstResponder(tableView)//focus tableView,doesnt work yet
        //self.initialFirstResponder = tableView
        table.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable //TODO: try to get height working here to
        tableContainer.documentView = table
        tableContainer.hasVerticalScroller = true
        view.addSubview(tableContainer)//add tableView to the window view
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
    /*
    * EventHandler for the button
    */
    func myAction(obj:AnyObject!){
        //Swift.print(ClassParser.getClass(obj))
        //Swift.print("My class is \((obj as! NSObject).className)")
        if let button = obj as? NSButton{
            switch button.title{
            case titles[0]:
                Swift.print(titles[0])
            case titles[1]:
                Swift.print(titles[1])
            case titles[2]:
                Swift.print(titles[2])
            case titles[3]:
                Swift.print(titles[3])
            case titles[4]:
                Swift.print(titles[4])
                //do debug stuff
            default:
                break
            }
        }
    }
    
}

