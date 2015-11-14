import Cocoa

class WinView:FlippedView{
    
    override func drawRect(dirtyRect: NSRect) {
        createContent()
    }
    /**
     *
     */
    func createContent(){
        testGraphic()
    }
    /**
     *
     */
    func testGraphic(){
        let a = GraphicsTest(0,0,200,200)
        
        self.addSubview(a)
        a.clear()
        
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