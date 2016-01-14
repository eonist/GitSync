import Cocoa
class WinView2:FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    //override var wantsUpdateLayer:Bool{return false;}
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //wantsLayer = false
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /*
    override func drawRect(dirtyRect: NSRect) {
    //Swift.print("WinView.drawRect()")
    }
    */
    func createContent(){
        
        //continue here:
        
        
        
        
            //test gradient
            //test button with skin change
            //implement the new interactiveElement approach into the button
            //test TextButton
            //test overlapping buttons
            //implement the outer shadow on the Graphic it self.
            //test tab bar example with perfect css
        
        //implement the svg engine
        //implement the float system
        //try to implement radial gradient as it was in the original concept
        //make the Radio bullet example and post a gif brewery animation on twitter and on github (maybe add a touch of animation?)
        
        
        
        
        
        //continue here: how does the css radial gradient work, see test cases, and do test cases.
        //resserach how the radial gradient look in svg syntax and compare the two,
        //then try to fit this into your current way of handeling gradients in the Graphics instance
        //we may need to support relative and absolute values when dealing with radial svg gradients asswell. see output from illustrator
        
        //So what you do is that you forget about setting the value for the innermost circle, always set this to 0% or 100% or something, if you need the innermost circle bigger this is done via the matrix transform and scaling the outermost circle down
        //do a test of your RadialGradient setup, does it mimic that of what illustrator gives. do many tests to be sure, also try to apply matrix to these values to make sure this works, does the focalPoint work, can you mimic any scenario?
        
        

        cssGradientTest()
        //gradientTest()
        //radialGradientTest2()
        //fileTest()
        //linearGradientTest()
        
        //radialGradientTest()
        //let f = FillStyle(Colors.red())
        //let c = f.copy() as! FillStyle
        //Swift.print("c.color.hex: " + "\(c.color.hex)")
        
        //testTabBar()
        //testDropShadow()
        //testOverlapping()
        //testTextButton()
        //testButton()
        //testTempRoundRect()
        //testLayerBackedElement()
        //testGraphic()
    }
    /**
     *
     */
    func cssGradientTest(){
        
        //you need to resolve the issue with GradientGraphic not beeing positionable. Consider the implications for LineGraphic, EllipseGraphic, RectGraphic, SVGAssetGraphic when you impliment this
        
        //you should probably support absolute variables aswell not just % THink SVG and how we do it there
        let css:String = "Element{fill:radial-gradient(50% 50% 100% 100% 0 0, red 1 0,green 1 1);}"//,blue 0.33 0.4724
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        let style:IStyle = styleCollection.getStyle("Element")!
        let styleProperty:IStyleProperty = style.getStyleProperty("fill")!
        let gradient:IGradient = styleProperty.value as! IGradient
        gradient
        
        
        
        
        /*
        Swift.print("gradient.gradientType: " + "\(gradient.gradientType)")
        Swift.print("gradient.relativeStartCenter: " + "\(gradient.relativeStartCenter)")
        Swift.print("gradient.relativeEndCenter: " + "\(gradient.relativeEndCenter)")
        Swift.print("gradient.relativeStartRadius: " + "\(gradient.relativeStartRadius)")
        Swift.print("gradient.rotation: " + "\(gradient.rotation)")
        */
        
        
        StyleManager.addStyle(styleCollection.styles)
        let element:Element = Element(200,200)
        addSubview(element)
        
        
        
        
        
        //TODO: think about including a dual system where you can also fully utilize the 2point 2size system aswell as the focalpoinratio system.
        //TODO: can you achive the same result through a 2 point gradient system as you can with matrix?, experiment, make tools , an outline, and maybe a handle etc
        
        
    }
    /**
     * Gradient unit test for the Graphic framework
     */
    func gradientTest(){
        /**/let gradient = Gradient(Gradients.bw(),[],GradientType.Linear,π/2)
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        
        let rect = RectGraphic(0,0,100,100,fill,nil)
        addSubview(rect.graphic)
        rect.draw()
        
        let gradient2 = Gradient(Gradients.bw(),[],GradientType.Linear,π/4)
        let fill2:GradientFillStyle = GradientFillStyle(gradient2);
        let rect2 = RectGraphic(100,0,100,100,fill2,nil)
        addSubview(rect2.graphic)
        rect2.draw()
        
        let gradient3 = Gradient(Gradients.bw(),[],GradientType.Radial,π/2,CGPoint(0.5,0.5)/*startP*/,CGPoint(0,0)/*y-focalRatio*/,CGSize(1,1)/*start-scale*/,CGSize(0,0)/*endScale*/)
        let fill3:GradientFillStyle = GradientFillStyle(gradient3);
        let rect3 = RectGraphic(0,100,100,100,fill3,nil)
        addSubview(rect3.graphic)
        rect3.draw()
        
        let gradient4 = Gradient(Gradients.bw(),[],GradientType.Radial,π/4,CGPoint(0.5,0.5)/*startP*/,CGPoint(0,-1)/*y-focalRatio*/,CGSize(1,1)/*start-scale*/,CGSize(0,0)/*endScale*/)
        let fill4:GradientFillStyle = GradientFillStyle(gradient4);
        let rect4 = RectGraphic(100,100,100,100,fill4,nil)
        addSubview(rect4.graphic)
        rect4.draw()
    }
    /**
     *
     */
    func radialGradientTest2(){
        let gradient = Gradient(Gradients.lightBlue(),[],GradientType.Radial,π/2,CGPoint(0.5,0.5)/*startP*/,CGPoint(0,0)/*y-focalRatio*/,CGSize(1,1)/*start-scale*/,CGSize(0,0)/*endScale*/)
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        /*Rect*/
        let rectGraphic = RectGraphic(40,40,200,200,fill,nil)
        addSubview(rectGraphic.graphic)
        rectGraphic.draw()
    }
    /**
     *
     */
    func fileTest(){
        //open txt and store it
        //let path = "\(NSHomeDirectory())/Desktop/del.txt"//"//Users/<path>/someFile.xml"//"\(NSHomeDirectory())/Desktop/file.txt"
        let path = "~/Desktop/del.txt".tildePath //let location = "~/file.txt".stringByExpandingTildeInPath
        let fileExists = FileAsserter.exists(path)
        Swift.print("fileExists: " + "\(fileExists)")
        
        
        let success = FileModifier.write(path, content: "test")
        Swift.print("success: " + "\(success)")
              
        
        let content = FileParser.content(path)
        Swift.print("content: " + "\(content)")
        
        
       
        
        
        /*
        let theURL:NSURL = NSURL(fileURLWithPath: FilePathParser.appDocPath())
        let filename = theURL.URLByAppendingPathComponent("output.txt")
        */
        

        
    }
    
    /**
     *
     */
    func linearGradientTest(){
        /*Gradients*/
        let gradient = Gradient(Gradients.red(),[],GradientType.Linear,π/2)
        let lineGradient = Gradient(Gradients.teal(0.5),[],GradientType.Linear,π/2)
        /*Styles*/
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.Round)
        let line:GradientLineStyle = GradientLineStyle(lineGradient,lineStyle)
        /*Rect*/
        let rect = RectGraphic(40,40,200,200,fill,line)
        addSubview(rect.graphic)
        rect.draw()
        /*Ellipse*/
        
        let ellipse = EllipseGraphic(300,40,200,200,fill.mix(Gradients.teal()),line.mix(Gradients.blue(0.5)))
        addSubview(ellipse.graphic)
        ellipse.draw()
        /*RoundRect*/
        let roundRect = RoundRectGraphic(40,300,200,200,Fillet(50),fill.mix(Gradients.orange()),line.mix(Gradients.yellow(0.5)))
        addSubview(roundRect.graphic)
        roundRect.draw()
        /*Line*/
        let lineGraphic = LineGraphic(CGPoint(300,300),CGPoint(500,500),line.mix(Gradients.deepPurple()))
        addSubview(lineGraphic.graphic)
        lineGraphic.draw()
        /**/
    }
    
    /**
     * Add args that enable disable infinite gradient etc
     */
    func radialGradientTest(){
        //let gradient = Gradient(Gradients.red(),[],GradientType.Linear,π/2)
        let gradient = Gradient(Gradients.red(),[],GradientType.Radial,π/2,CGPoint(0.5,0.5)/*startP*/,CGPoint(0,0)/*y-focalRatio*/,CGSize(1,1)/*start-scale*/,CGSize(0,0)/*endScale*/)
        //let fill:FillStyle = FillStyle(NSColor.redColor())
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        
        //let lineGradient = Gradient(Gradients.teal(0.5),[],GradientType.Linear,π/2,CGPoint(0.5,0.5)/*startP*/,CGPoint(0,0)/*y-focalRatio*/,CGSize(1,1)/*start-scale*/,CGSize(0,0)/*endScale*/)
        //let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.Round)
        //let line = GradientLineStyle(lineGradient,lineStyle)
        
        /*Rect*/
        let rectGraphic = RectGraphic(40,40,200,200,fill,nil)
        addSubview(rectGraphic.graphic)
        rectGraphic.draw()
        
       
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
    func testDropShadow(){
        
        
        var css = "Element{fill:yellow;}"
        css += "Element{drop-shadow:drop-shadow(0px 0 #000000 0.4 14 14 1 2 false);}"//outer
        //css += "Element{drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);}"//inner
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
        self.addSubview(btn2)
    }
    
    func testTextButton(){
        var css:String = "TextButton{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:gray;line-alpha:0.6;line-thickness:1px;corner-radius:4px;line-offset-type:outside;}"
        css += "TextButton:down{fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);line:gray;line-alpha:0.9;line-thickness:1px;corner-radius:4px;line-offset-type:outside;}"
        //var css:String = "TextButton{fill:red;}TextButton:over{fill:yellow;}TextButton:down{fill:green;}"
        css += "Text{font:Lucida Grande;selectable:false;size:12px;color:gray;align:center;backgroundColor:orange;background:false;margin-top:4px;}Text:down{color:black;}"//
        StyleManager.addStyle(css)
        //btn = TextButton("",200,200)
        let textButton:TextButton = TextButton("Button",96,24)
        
        
        textButton.setPosition(CGPoint(20,20))
        self.addSubview(textButton)
    }
    //var delGraphic:DelGraphic = DelGraphic(frame: NSRect(-20,-20,100,100))
    func testButton(){
        //let css:String = "Button{fill:red;}Button:over{fill:yellow;}Button:down{fill:green;}"//
        var css:String = "Button{fill:linear-gradient(top,#FFFEFE,#E8E8E8);line:gray;line-alpha:0.6;line-thickness:1px;corner-radius:4px;line-offset-type:outside;}"
        css += "Button:down{fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);line:gray;line-alpha:0.9;line-thickness:1px;corner-radius:4px;line-offset-type:outside;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let button = Button(96,24,100,100)
        
        //button.setPosition(CGPoint(120,120))
        self.addSubview(button)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: button)
        
        
        //self.addSubview(delGraphic)
        
    }
    func onButtonDown(sender: AnyObject) {
        Swift.print("WinView2.onButtonDown() ")
        //delGraphic.layer?.setNeedsDisplay()
        //let textButton:Button = (sender as! NSNotification).object as! Button
        /*
        if((sender as! NSNotification).object === self.textButton!){
        Swift.print("sender.object === self.textButton")
        }
        */
        
        /*
        Swift.print("object: " + String((sender as! NSNotification).object))
        Swift.print("name: " + String((sender as! NSNotification).name))//buttonEventDown
        Swift.print("userInfo: " + String((sender as! NSNotification).userInfo))//nil
        */
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
        let css = "Element{fill:linear-gradient(top,red,blue);line:linear-gradient(top,green,orange);line-alpha:0.5;line-offset-type:outside;line-thickness:20px;corner-radius:20px;}"
        //css = "Element{fill:red;}"
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
class SomeClass:SomeProtocol{
    required init(){
        
    }
}
protocol SomeProtocol{
    init()
}