import Cocoa

class TempGraphic:Graphic{
    var x:Int
    var y:Int
    var width:Int
    var height:Int
    var color:NSColor
    var thePath:CGMutablePath
    init(_ x:Int = 0, _ y:Int = 0,_ width:Int = 0, _ height:Int = 0, _ color:NSColor = NSColor.blueColor()) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.color = color
        self.thePath = CGPathParser.rect(CGFloat(width/*/2*/),CGFloat(height/*/2*/))//Shapes
        let offsetType:OffsetType = OffsetType(OffsetType.outside)
        
        /*
        offsetType.top = OffsetType.outside
        offsetType.bottom = OffsetType.outside
        offsetType.left = OffsetType.inside
        offsetType.right = OffsetType.outside
        */
        /**/
        super.init(FillStyle(NSColor.yellowColor().alpha(0.5)),LineStyle(20,NSColor.blueColor().alpha(0.5)),offsetType)
        
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
        
        //a.masksToBounds = false
        
        let rect:CGRect = CGRect(0,0,200,200)//these values will be derived from somewhere else in the future
        
        let offsetRect = RectGraphicUtils2.offsetRect(rect, lineShape.lineStyle!, lineOffsetType)
        fillShape.frame = offsetRect.fillRect/*,position and set the size of the frame*/
        fillShape.path = CGRect(0,0,rect.width,rect.height).path/*Draws in the local coordinate space of the shape*/
        fillShape.display()/*draw the fileShape*/
        //alignStroke(self)
        
        //Swift.print("offsetRect.fillRect: " + "\(offsetRect.fillRect)")
        //Swift.print("offsetRect.lineFrameRect: " + "\(offsetRect.lineFrameRect)")
        Swift.print("offsetRect.lineRect: " + "\(offsetRect.lineRect)")
        
        lineShape.frame = NSRect(0,0,400,400)//offsetRect.lineFrameRect
        lineShape.path = offsetRect.lineRect.path
        lineShape.display()/*draw the lineShape*/
        
        
        
        //continue here: implement the lineRect
        
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
