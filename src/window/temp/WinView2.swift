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
        
        //continue here:
        
            //test gradient
        //test button with skin change
        //implement the new interactiveElement approach into the button
        //test TextButton
        //test overlapping buttons
        //implement the outer shadow on the Graphic it self.
        //test tab bar example with perfect css
        
        //try to implement radial gradient as it was in the original concept
        //make the Radio bullet example and post a gif brewery animation on twitter and on github
        //tomorrow implement the svg engine
        
        testButton()
        //testTempRoundRect()
        //testLayerBackedElement()
        //testGraphic()
    }
    func testButton(){
        let css:String = "Button{fill:red;}Button:over{fill:yellow;}Button:down{fill:green;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let button = Button(200,200,20,20)
        
        //button.setPosition(CGPoint(120,120))
        self.addSubview(button)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: button)
    }
    func onButtonDown(sender: AnyObject) {
        Swift.print("WinView2.onButtonDown() ")
        //let textButton:Button = (sender as! NSNotification).object as! Button
        /*
        if((sender as! NSNotification).object === self.textButton!){
        Swift.print("sender.object === self.textButton")
        }
        */
        
        Swift.print("object: " + String((sender as! NSNotification).object))
        Swift.print("name: " + String((sender as! NSNotification).name))//buttonEventDown
        Swift.print("userInfo: " + String((sender as! NSNotification).userInfo))//nil
        //Swift.print("WinView.onButtonDown() Sender: " + String(sender))
    }
   
    func testTempRoundRect(){
        let a = TempRoundRect()
        self.addSubview(a)
    }
    func testLayerBackedElement(){
        //fill-alpha:0.5
        //fill:red;
        //line:red;
        var css = "Element{fill:linear-gradient(top,red,blue);line:linear-gradient(top,green,orange);line-alpha:0.5;line-offset-type:outside;line-thickness:20px;corner-radius:20px;}"
        css = "Element{fill:red;}"
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