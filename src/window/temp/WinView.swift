import Cocoa

class WinView:FlippedView{
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
        //super.drawRect(dirtyRect)
        //gradientBoxTest()
    }
    func createContent(){
        testCALayer()
       
        //testDropShadow()
        //testOverlapping()
        //styleTesting()
        //testTabBar()
        //testSelectGroup()
        //let gradientBoxTest = GradientBoxTest(frame: NSRect(0,0,100,100))
        //addSubview(gradientBoxTest)
        //gradientTest()
        //testTextButton()
        //testButton()
        //testTextElement()
        //testRotation()
        //testSkin()
        //testGraphic()
    }
    func testCALayer(){
        //create an nsview with the right wants layer etc implementations
        let rootView = View2()
        self.addSubview(rootView)
        //add calayer to this nsview
        
        //setup overlapping etc. 
        
        //test refreshing a partly overlapping sibling
        
        //test hittesting the different layers, blocking etc
        
        //test mouse enter exit etc for diferent layers etc. 
        
        //create a new graphic class with line and fill in seperate layers and also with an outer shadow and inner shadow support
        
        //start implementing outside/inside/center drawing
        
        
    }
    func testDropShadow(){
        
        
        var css = "Element{fill:red;line:blue;line-offset-type:center;line-thickness:15px;}"
        css += "Element{drop-shadow:drop-shadow(0px 0 #000000 0.4 14 14 1 2 true);}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        //let styleProperty = styleCollection.getStyle("Element")?.getStyleProperty("drop-shadow")
        //Swift.print("styleProperty.value: " + String(styleProperty!.value))
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(200,200,20,20)
        self.addSubview(element)

    }
    func testOverlapping(){
        var css = ""
        css += "Button#first{fill:red;}"
        css += "Button#first:over{fill:yellow;fill-alpha:0.2;}"
        css += "Button#second{fill:blue;}"
        StyleManager.addStyle(css)
        let btn1 = Button(200,40,nil,"first")
        btn1.setPosition(CGPoint(20,20))
        self.addSubview(btn1)
        
        let btn2 = Button(200,40,nil,"second")
        btn2.setPosition(CGPoint(120,20))
        self.addSubview(btn2, positioned: NSWindowOrderingMode.Above, relativeTo: btn1)
    }
    func styleTesting(){
        var css = ""
        css += "Element#first{fill:red;corner-radius-top-left:40px;}"
        css += "Element#second{fill:blue;corner-radius-bottom-left:40px;}"
        css += "Element#third{fill:yellow;corner-radius-top-right:40px;}"
        css += "Element#fourth{fill:green;corner-radius-bottom-right:40px;}"
        StyleManager.addStyle(css)
        self.addSubview(Element(150,150,nil,"first"))
        self.addSubview(Element(150,150,0,150,nil,"second"))
        self.addSubview(Element(150,150,150,0,nil,"third"))
        self.addSubview(Element(150,150,150,150,nil,"fourth"))
    }
    func testTabBar(){
        
        //continue here: maybe implement height with the Text element
        //continue here: make parenting work with element
        //and turn off mouseHover -> skin update if there is no update
        //dropshadow
        //fix the mouseover exit problem, try overlapping shapes to see whats wrong
        
        var css:String = "SelectTextButton{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:grey7;line-offset-type:outside;line-thickness:1px;drop-shadow:none;}"//
        css += "SelectTextButton#first{corner-radius:4px 0px 4px 0px;}"
        css += "SelectTextButton#second{corner-radius:0px 0px 0px 0px;line-offset-type-right,line-offset-type-left:inside;}"//
        css += "SelectTextButton#third{corner-radius:0px 4px 0px 4px;}"//
        css += "SelectTextButton Text{font:Lucida Grande;selectable:false;size:12px;color:gray;align:center;backgroundColor:orange;background:false;margin-top:5px;}"//
        css += "Text:down{color:black;}"
        css += "SelectTextButton:selected Text{color:white;}"
        css += "SelectTextButton:selected{fill:linear-gradient(top,grey9,grey8);drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);}"

      
        
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        
        //let styleProperty = styleCollection.getStyle("SelectButton")?.getStyleProperty("corner-radius")
        //Swift.print("styleProperty.value: " + String(styleProperty!.value))
        StyleManager.addStyle(styleCollection.styles)
        let btn1 = SelectTextButton("first",64,24,false,nil,"first")
        btn1.setPosition(CGPoint(10,20))
        self.addSubview(btn1)
        
        let btn2 = SelectTextButton("second",64,24,true,nil,"second")
        btn2.setPosition(CGPoint(74,20))
        self.addSubview(btn2)
        
        let btn3 = SelectTextButton("third",64,24,false,nil,"third")
        btn3.setPosition(CGPoint(138,20))
        self.addSubview(btn3)
        
        addSubview(SelectGroup([btn1,btn2,btn3],btn2));
        
    }
    func testSelectGroup(){
        let css:String = "SelectButton{fill:red;}SelectButton:over{fill:yellow;}SelectButton:down{fill:green;}SelectButton:selected{fill:blue;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let btn1 = SelectButton(200,40)
        //btn1.setPosition(CGPoint(20,20))
        self.addSubview(btn1)
        
        
        /*
        let notificationTest = NotificationTest()
        addSubview(notificationTest)
        notificationTest.test(btn1)
        */
        
        let btn2 = SelectButton(200,40)
        btn2.setPosition(CGPoint(0,60))
        self.addSubview(btn2)
        /**/
        
        let btn3 = SelectButton(200,40)
        btn3.setPosition(CGPoint(0,120))
        self.addSubview(btn3)
        
        
        let selectGroup = SelectGroup([btn1,btn2,btn3])
        addSubview(selectGroup)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSelect:", name: SelectGroupEvent.select, object: selectGroup)
        
        /**/
    }
    func onSelect(notification: NSNotification) {
        Swift.print("TestSelectGroup.onSelect()")
        Swift.print("TestSelectGroup.onSelect: " + String(notification.object))/* as ISelectable).isSelected*/
        
        //selected should be blue (see old css code)
        //deselect should work
        //try 3 buttons
        
    }
    /**
     *
     */
    func test(btn:Button){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: btn)
    }
    
    /**
     *
     */
    func gradientTest(){
        //
        //
        let css:String = "Element{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:gray;line-alpha:0.6;line-thickness:1px;corner-radius:4px;line-offset-type:center;}"//"Blob{fill:green;fill-alpha:1.0;corner-radius:10px;}"//
        //let css:String = "Element{fill:linear-gradient(left,green,yellow,red);}"
        /*
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        let styleProperty = styleCollection.getStyle("Element")?.getStyleProperty("fill")
        let gradient:IGradient = styleProperty?.value as! IGradient
        Swift.print("gradient.colors.count: " + "\(gradient.colors.count)")
        Swift.print("gradient.locations.count: " + "\(gradient.locations.count)")
        */
        StyleManager.addStyle(css)
        element = Element(196,54,0,0)
        self.addSubview(element!)

    }
    
    override func mouseDown(theEvent: NSEvent) {
        //Swift.print("WinView.mouseDown() type: " + String(theEvent.type.rawValue) + " " + String(theEvent))
        self.needsDisplay = true
        super.mouseDown(theEvent)
    }
    
    var textButton:TextButton!
    //var btn:TextButton!
    func testTextButton(){
        var css:String = "TextButton{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:gray;line-alpha:0.6;line-thickness:1px;corner-radius:4px;line-offset-type:center;}"
        css += "TextButton:down{fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);line:gray;line-alpha:0.9;line-thickness:1px;corner-radius:4px;line-offset-type:center;}"
        //var css:String = "TextButton{fill:red;}TextButton:over{fill:yellow;}TextButton:down{fill:green;}"
        css += "Text{font:Lucida Grande;selectable:false;size:12px;color:gray;align:center;backgroundColor:orange;background:false;margin-top:4px;}Text:down{color:black;}"//
        StyleManager.addStyle(css)
        //btn = TextButton("",200,200)
        textButton = TextButton("Button",96,24)
        textButton.setPosition(CGPoint(20,20))
        
        
        
        self.addSubview(textButton!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: textButton)
    }
    func onButtonDown(sender: AnyObject) {
        Swift.print("WinView.onButtonDown() ")
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
    func testButton(){
        let css:String = "Button{fill:red;line:blue;line-offset-type:inside;line-thickness:15px;drop-shadow:drop-shadow(0px 0 #000000 0.9 4 4 1 2 true);}Button:over{fill:yellow;drop-shadow:none;}Button:down{fill:green;drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let button = Button(200,200,20,20)
        //button.setPosition(CGPoint(120,120))
        self.addSubview(button)
    }
    func testTextElement(){
        //textColor
        let css:String = "Text{font:Lucida Grande;selectable:false;size:22px;color:blue;align:center;backgroundColor:orange;background:true;margin-top:10px;margin-left:10px;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        let fontName = styleCollection.getStyle("Text")?.getStyleProperty("font")?.value
        Swift.print("Font name: " + "\(fontName)")
        //let temp = styleCollection.getStyle("Text")?.getStyleProperty("selectable")?.value
        //Swift.print("temp.dynamicType: " + "\(temp!.dynamicType)")
       
        //*
        StyleManager.addStyle(styleCollection.styles)
        let text = Text(200,40,"Hello world")
        self.addSubview(text)
        //*/
    }
    func testSkin(){
        
        
        
        
        //Continue here: try margin with the text element, implement align in the TextSkin, make it work with the new textfield class etc
        
        
        
        
        /*
        line:white9;
        line-alpha:1;
        line-offset-type:outside;
        line-thickness:1px;
        */
        //"Button{fill:red;} CheckButton{line:blue;}"
        //fill:purple;fill-alpha:1.0;corner-radius:10px;fill:linear-gradient(top,red,blue);
        //line:linear-gradient(bottom,green,orange);
        //fill:linear-gradient(top,red,blue);
        //line-alpha:1.0;
        //var css:String = "Element{fill:red;fill-alpha:0.5;line:blue;line-alpha:0.5;line-thickness:20px;corner-radius:10px;line-offset-type:center;}"//"Blob{fill:green;fill-alpha:1.0;corner-radius:10px;}"//
        let css = "Element{fill:linear-gradient(top,blue,red);margin-top:20px;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(200,200,0,0)
        self.addSubview(element)
        
        
        //let blob = Blob(150,250)
        //view.addSubview(blob)
        
        
    }
    func testRotation(){
        let circle = Graphic()
        addSubview(circle)
        //red circle
        circle.path.add(CGPathParser.circle(25,0,0))
        let startPos = CGPoint(100,100)
        
        CGPathModifier.translate(&circle.path,startPos.x,startPos.y)//Transformations
        circle.graphics.fill(NSColor.redColor())
        circle.graphics.draw(circle.path)
        
        //yellow circle
        circle.path = CGPathParser.circle(25,0,0)
        circle.graphics.fill(NSColor.yellowColor())
        Swift.print(Trig.pi)
        Swift.print(String(Trig.pi*2))
        let position = CGPoint.polarPoint(100,CGFloat(-Trig.pi/4*3))
        let pos = CGPoint(position.x, position.y)
        let newPos = startPos + pos
      
        Swift.print(String(newPos))
        CGPathModifier.translate(&circle.path,newPos.x,newPos.y)//Transformations
        circle.graphics.draw(circle.path)
    }
    
    /**
     *
     */
    func testGraphic(){
        let a = GraphicsTest(0,0,300,300)
        
        self.addSubview(a)
        
        /*
        let b = GraphicsTest(50,50,200,200,NSColor.purpleColor())
        view.addSubview(b)
        b.draw()
        */
        //b.clear()
        
        //continue here: it seems needsDisplay = true, isnt imidiate, using drawRect() seems to work better
        //try to get this working with shape
        
    }
}
class NotificationTest:NSView{
    
    /**
     *
     */
    func test(btn:Button){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: btn)
    }
    func onButtonDown(notification: NSNotification) {
        Swift.print("NotificationTest.onButtonDown() ")
        //let textButton:Button = (sender as! NSNotification).object as! Button
        /*
        if((sender as! NSNotification).object === self.textButton!){
        Swift.print("sender.object === self.textButton")
        }
        */
        
        Swift.print("object: " + String((notification as NSNotification).object))
        Swift.print("name: " + String((notification as NSNotification).name))//buttonEventDown
        Swift.print("userInfo: " + String((notification as NSNotification).userInfo))//nil
        //Swift.print("WinView.onButtonDown() Sender: " + String(sender))
    }
}