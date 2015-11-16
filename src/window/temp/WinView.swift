import Cocoa

class WinView:FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override func drawRect(dirtyRect: NSRect) {
        createContent()
        
    }
    /**
     *
     */
    func createContent(){
        testRotation()
        //testSkin()
        //testGraphic()
    }
    /**
     *
     */
    func testRotation(){
        let circle = Graphic()
        addSubview(circle)
        //red circle
        circle.path.add(CGPathParser.circle(25,0,0))
        //CGPathModifier.translate(&circle.path,CGFloat(100),CGFloat(100))//Transformations
        circle.graphics.fill(NSColor.redColor())
        circle.graphics.draw(circle.path)
        //yellow circle
        circle.path = CGPathParser.circle(25,0,0)
        circle.graphics.fill(NSColor.yellowColor())
        Swift.print(Trig.pi)
        Swift.print(String(Trig.pi*2))
        let position = PointParser.polarPoint(100,Trig.pi/8)
        Swift.print(String(position))
        CGPathModifier.translate(&circle.path,CGFloat(position.x),CGFloat(position.y))//Transformations
        circle.graphics.draw(circle.path)
        
    }
    /**
     *
     */
    func testSkin(){
        //"Button{fill:red;} CheckButton{line:blue;}"
        //fill:purple;fill-alpha:1.0;corner-radius:10px;
        let css:String = "Element{fill:linear-gradient(top,red,blue);}"//"Blob{fill:green;fill-alpha:1.0;corner-radius:10px;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(200,200)
        self.addSubview(element)
        
        
        //continue here, impliment support for correct rotation
        
        
        //let blob = Blob(150,250)
        //view.addSubview(blob)
        
        
    }
    /**
     *
     */
    func testGraphic(){
        let a = GraphicsTest(0,0,300,300)
        
        self.addSubview(a)
        
        
        //continue here, you need modell your classes so that when drawRect is called, graphics is created, so that graphics is attached to that NSView
        
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