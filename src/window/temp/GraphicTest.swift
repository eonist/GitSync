import Cocoa

class GraphicsTest:Graphic{
    var x:Int
    var y:Int
    var width:Int
    var height:Int
    var color:NSColor
    init(_ x:Int = 0, _ y:Int = 0,_ width:Int = 100, _ height:Int = 100, _ color:NSColor = NSColor.blueColor()) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.color = color
        super.init()
        self.wantsLayer = false//this avoids calling drawLayer() and enables drawingRect()
        needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
    }
    
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     *
     */
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("GraphicsTest.drawRect: " )
        var path:CGPath = CGPathParser.rect(CGFloat(width/2),CGFloat(height/2))//Shapes
        CGPathModifier.translate(&path,CGFloat(x),CGFloat(y))//Transformations
        //graphics.line(12)//Stylize the line
        
        graphics.fill(color)//Stylize the fill
        graphics.draw(path)//draw everything
        
        //super.drawRect(dirtyRect)
    }
}