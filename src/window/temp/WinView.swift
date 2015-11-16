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
        let rect = Graphic()
        rect.path = CGPathParser.rect(100, 100, 0, 0)
        rect.graphics.fill(NSColor.redColor())
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