import Cocoa

class WinView:FlippedView{
    var element:Element?
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("WinView.drawRect()")
        //gradientBoxTest()
        //lineTest()
        //rectTest()
        //cricleTest()
        
    }
    func createContent(){
        //let gradientBoxTest = GradientBoxTest(frame: NSRect(0,0,100,100))
        //addSubview(gradientBoxTest)
        //gradientTest()
        testTextButton()
        //testButton()
        //testTextElement()
        //testRotation()
        //testSkin()
        //testGraphic()
    }
    func rectTest(){
        let rect = RectGraphic(300,300)
        //line.setPosition(CGPoint(150,150))
        rect.initialize()
    }
    func lineTest(){
        let line = LineGraphic(CGPoint(20,20),CGPoint(50,50))
        //line.setPosition(CGPoint(150,150))
        line.initialize()
    }
    func cricleTest(){
        let circle = CircleGraphic(10)
        circle.initialize()
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
        Swift.print("WinView.mouseDown() type: " + String(theEvent.type.rawValue) + " " + String(theEvent))
        self.needsDisplay = true
        super.mouseDown(theEvent)
    }
    var textButton:TextButton!
    func testTextButton(){
        var css:String = "TextButton{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:gray;line-alpha:0.6;line-thickness:1px;corner-radius:4px;line-offset-type:center;}"
        css += "TextButton:down{fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);line:gray;line-alpha:0.9;line-thickness:1px;corner-radius:4px;line-offset-type:center;}"
        //var css:String = "TextButton{fill:red;}TextButton:over{fill:yellow;}TextButton:down{fill:green;}"
        css += "Text{font:Lucida Grande;selectable:false;size:12px;color:gray;align:center;backgroundColor:orange;background:false;}Text:down{color:black;}"//
        StyleManager.addStyle(css)
        textButton = TextButton("Button",96,24)
        textButton.setPosition(CGPoint(20,20))
        
        
        //continue here: start testing margin-top with a rect shape 
        
        
        self.addSubview(textButton!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: self)
    }
    func onButtonDown(sender: AnyObject) {
        let textButton:TextButton = (sender as! NSNotification).object as! TextButton
        if(textButton === self.textButton!){
           Swift.print("Is correct textButton")
        }
    
    
        Swift.print(String((sender as! NSNotification).object))
        Swift.print(String((sender as! NSNotification).name))//buttonEventDown
        Swift.print(String((sender as! NSNotification).userInfo))//nil
        //Swift.print("WinView.onButtonDown() Sender: " + String(sender))
    }
    func testButton(){
        let css:String = "Button{fill:red;}Button:over{fill:yellow;}Button:down{fill:green;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let button = Button(200,40)
        self.addSubview(button)
    }
    func testTextElement(){
        //textColor
        let css:String = "Text{font:Lucida Grande;selectable:false;size:22px;color:blue;align:center;backgroundColor:orange;background:true;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        //let temp = styleCollection.getStyle("Text")?.getStyleProperty("selectable")?.value
        //Swift.print("temp.dynamicType: " + "\(temp!.dynamicType)")
       
        StyleManager.addStyle(styleCollection.styles)
        let text = Text(200,40,"Hello world")
        self.addSubview(text)
    }
    func testSkin(){
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
        let css = "Element{fill:red;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(200,200,50,50)
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