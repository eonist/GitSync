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
        super.init(FillStyle(NSColor.yellowColor().alpha(0.5)),LineStyle(20,NSColor.blueColor().alpha(0.5)),OffsetType(OffsetType.center))
        
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
        
        //a.masksToBounds = false
        Swift.print("layer!.contentsScale: " + "\(layer!.contentsScale)")
        let rect:CGRect = CGRect(50,50,100,100)
        
        fillShape.path = CGRect(0,0,rect.width,rect.height).path/*Draws in the local coordinate space of the shape*/
        fillShape.frame = rect/*,position and set the size of the frame*/
        fillShape.display()
        alignStroke(self)
        
        
        //fix the blurry edge problem with some research
        
        
        //draw the lineShape
        
        
        lineShape.display()
        
        Swift.print("lineShape.contentsScale: " + "\(lineShape.contentsScale)")
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
    /**
     * NOTE: this is for offseting rectangle
     * NOTE: The fill.frame is the position and location of the Graphic (the frame of the graphic is a ZeroRect, with no clipping)
     * NOTE: The path in fill.path is the path that line.path will be based on
     */
    func alignStroke(graphic:Graphic){
        //graphic.frame.width
        //graphic.frame.height
        //graphic.lineOffsetType
        //graphic.lineStyle!.thickness
        let thickness:CGFloat = graphic.lineStyle!.thickness
        let rect:CGRect = graphic.fillShape.frame
        if(graphic.lineOffsetType == OffsetType(OffsetType.center)){/*Asserts if all props of the lineOffsetType is of the center type*/
            let offsetRect = rect.outset(thickness/2, thickness/2)
            Swift.print("offsetRect: " + "\(offsetRect)")
            graphic.lineShape.frame = offsetRect
            let linePath = CGPathModifier.translate(&graphic.fillShape.path, thickness/2, thickness/2)/*move the path half the thickness left and down*/
            //graphic.lineShape.path = graphic.fillShape.path
        }else if(graphic.lineOffsetType == OffsetType(OffsetType.inside)){
            let offsetRect = rect.inset(thickness/2, thickness/2)
            Swift.print("offsetRect: " + "\(offsetRect)")
            graphic.lineShape.frame = graphic.fillShape.frame
            graphic.lineShape.path = offsetRect.path
        }else{//outside
            
            let frameOffsetRect = rect.outset(thickness, thickness)
            Swift.print("frameOffsetRect: " + "\(frameOffsetRect)")
            graphic.lineShape.frame = frameOffsetRect
            let lineOffsetRect = CGRect(thickness/2,thickness/2,rect.width+thickness,rect.height+thickness)/*you expand the rect in the 0,0 coordinatespace*/
            Swift.print("lineOffsetRect: " + "\(lineOffsetRect)")
            
            graphic.lineShape.path = lineOffsetRect.path
        }
    }
}