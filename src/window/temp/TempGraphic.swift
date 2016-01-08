import Cocoa

class TempGraphic:Graphic{
    var width:CGFloat
    var height:CGFloat
    //var color:NSColor
    //var thePath:CGMutablePath
    init(_ width:CGFloat = 0.0, _ height:CGFloat = 0.0/*, _ color:NSColor = NSColor.blueColor()*/) {
        self.width = width
        self.height = height
        //self.color = color
        //self.thePath = CGPathParser.rect(CGFloat(width/*/2*/),CGFloat(height/*/2*/))//Shapes
        let offsetType:OffsetType = OffsetType(OffsetType.outside)
        
        /*
        offsetType.top = OffsetType.outside
        offsetType.bottom = OffsetType.inside
        offsetType.left = OffsetType.outside
        offsetType.right = OffsetType.inside
        */
        let fillStyle = FillStyle(NSColor.yellowColor().alpha(0.5))
        let lineStyle = LineStyle(20,NSColor.blueColor().alpha(0.5))
        
        /**/
        super.init(fillStyle,lineStyle,offsetType)
        
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
        
        //a.masksToBounds = false
        
        let rect:CGRect = CGRect(x: 0,y: 0,width: width,height: height)//these values will be derived from somewhere else in the future
        
        let fillOffsetRect = RectGraphicUtils.fillFrame(rect, self.lineStyle!.thickness, lineOffsetType)
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(rect, self.lineStyle!, lineOffsetType)
        
        fillShape.frame = fillOffsetRect/*,position and set the size of the frame*/
        fillShape.path = CGRect(0,0,rect.width,rect.height).path/*Draws in the local coordinate space of the shape*/
        fillShape.display()/*draw the fileShape*/
        //alignStroke(self)
        
        /*
        Swift.print("offsetRect.fillFrameRect: " + "\(offsetRect.fillFrameRect)")
        Swift.print("offsetRect.lineFrameRect: " + "\(offsetRect.lineFrameRect)")
        Swift.print("offsetRect.lineRect: " + "\(offsetRect.lineRect)")
        */
        
        lineShape.frame = lineOffsetRect.lineFrameRect
        lineShape.path = lineOffsetRect.lineRect.path
        lineShape.display()/*draw the lineShape*/
        
        //layer!.display()
        
        //Swift.print("fillStyle.color: " + "\(fillStyle.color)")
        lineShape.delegate = self
        fillShape.delegate = self
    }
    /**
     * This is a delegate handler method
     */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        //Swift.print("Graphic.drawLayer(layer,inContext)")
        if(layer === fillShape){
            //Swift.print("fillShape")
            fillShape.graphics.context = ctx
            
            //TODO:you only need to call the draw method from here, the fill setting etc can be done in the decoratable classes
            
            fillShape.graphics.fill(fillStyle!.color)//Stylize the fill
            //Swift.print("inside drawInContext")
            fillShape.graphics.draw(fillShape.path)//draw everything
            
        }else if(layer === lineShape){
            //Swift.print("lineShape")
            lineShape.graphics.context = ctx
            
            //TODO:you only need to call the draw method from here, the line setting etc can be done in the decoratable classes
            
            lineShape.graphics.line(lineStyle!.thickness,lineStyle!.color/*,lineStyle!.lineCap, lineStyle!.lineJoin, lineStyle!.miterLimit*/)//Stylize the line
            lineShape.graphics.draw(lineShape.path)//draw everything
            
        }
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
