import Cocoa

class WinView2:FlippedView{
    var element:Element?
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    //override var wantsUpdateLayer:Bool{return false;}
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //wantsLayer = true
        createContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("WinView.drawRect()")
    }
    func createContent(){
        
        
        
        //testTempRoundRect()
        
        
        testLayerBackedElement()
        //testGraphic()
    }
    /**
    *
    */
    func testTempRoundRect(){
        let a = TempRoundRect()
        self.addSubview(a)
    }
    func testLayerBackedElement(){
        let css = "Element{fill:green;fill-alpha:0.5;line:red;line-alpha:0.5;line-offset-type:outside;line-thickness:20px;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(200,200,100,100)
        self.addSubview(element)
    }
    func testGraphic(){
        let a = TempGraphic(200,200)
        //a.frame.origin = (NSPoint(100,100))
        
        //Swift.print("a.frame: " + "\(a.frame)")
        //Swift.print("a.layer?.frame: " + "\(a.layer?.frame)")
        self.addSubview(a)
        //Swift.print("a.frame: " + "\(a.frame)")
        
        //let rect = CGRect(0,0,100,100)
        /*
        let b = TempGraphic()
        a.addSubview(b)
        //Swift.print("a.layer!.masksToBounds: " + "\(a.layer!.masksToBounds)")
        b.frame.origin = (NSPoint(-50,50))
        
        //b.layer!.masksToBounds = false
        */
        /*
        let c = DelGraphic(frame: NSRect(-20,-20,100,100))
        a.addSubview(c)
        
        let textField = NSText(frame: NSRect(x: -50, y: 0, width: 200, height: 200))//set w and h to 0
        textField.string = "Testing"
        textField.backgroundColor = NSColor.clearColor()
        a.addSubview(textField)
        */
    }
}