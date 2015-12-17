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
        super.init(FillStyle(NSColor.orangeColor()),LineStyle(15),OffsetType(OffsetType.center))
        
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
        
        //a.masksToBounds = false
        let a:Shape = fillShape//TempShape()
        a.path = CGPathParser.rect(CGFloat(100/*/2*/),CGFloat(100/*/2*/))/*Draws in the local coordinate space of the shape*/
        a.frame = CGRect(0,0,100,100);/*,position and set the size of the frame*/
        a.display()
        alignGraphic(self)
        //draw the lineShape
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
    /**
     * NOTE: The fill.frame is the position and location of the Graphic (the frame of the graphic is a ZeroRect, with no clipping)
     * NOTE: The path in fill.path is the path that line.path will be based on
     */
    func alignGraphic(graphic:Graphic){
        //graphic.frame.width
        //graphic.frame.height
        //graphic.lineOffsetType
        //graphic.lineStyle!.thickness
        let thickness:CGFloat = graphic.lineStyle!.thickness
        let rect:CGRect = graphic.fillShape.frame
        if(graphic.lineOffsetType == OffsetType(OffsetType.inside)){/*Asserts if all props of the lineOffsetType is of the inside type*/
            let offsetRect = rect.outset(thickness/2, thickness/2)
            
            Swift.print("offsetRect: " + "\(offsetRect)")
        }
    }
}