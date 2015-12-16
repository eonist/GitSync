import Cocoa

class GraphicsTest:Graphic{
    var x:Int
    var y:Int
    var width:Int
    var height:Int
    var color:NSColor
    var thePath:CGMutablePath
    init(_ x:Int = 0, _ y:Int = 0,_ width:Int = 100, _ height:Int = 100, _ color:NSColor = NSColor.blueColor()) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.color = color
        self.thePath = CGPathParser.rect(CGFloat(width/*/2*/),CGFloat(height/*/2*/))//Shapes
        super.init()
        lineStyle = LineStyle(15)
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
    }
    /*
    override func displayLayer(layer: CALayer) {
    //try
    Swift.print("displayLayer")
    }
    */
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
        
        CGPathModifier.translate(&thePath,CGFloat(25),CGFloat(25))//Transformations
        
        
        fillShape.graphics.fill(color)//Stylize the fill
        fillShape.graphics.draw(thePath)//draw everything
        
        //alignGraphic(self)
        lineShape.graphics.line(lineStyle!.thickness)//Stylize the line
        lineShape.graphics.draw(thePath)//draw everything
        
        //super.drawRect(dirtyRect)
    }
    func alignGraphic(graphic:Graphic){
        //graphic.frame.width
        //graphic.frame.height
        //graphic.lineOffsetType
        //graphic.lineStyle!.thickness
        let thickness:CGFloat = graphic.lineStyle!.thickness
        let rect:CGRect = graphic.frame
        if(graphic.lineOffsetType == OffsetType(OffsetType.inside)){/*Asserts if all props of the lineOffsetType is of the inside type*/
            let offsetRect = rect.outset(thickness/2, thickness/2)
            graphic.fillShape.frame = NSRect(0,0,50,50)
            
            Swift.print("offsetRect: " + "\(offsetRect)")
        }
    }
}