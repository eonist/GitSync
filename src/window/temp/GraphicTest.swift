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
        //alignStroke(self)
        let offsetRects = RectGraphicUtil.offsetRect(fillShape.frame, lineShape.lineStyle!, lineOffsetType)
        lineShape.frame = offsetRects.frameRect
        lineShape.path = offsetRects.lineRect.path
        lineShape.display()/*draw the lineShape*/
        Swift.print("lineShape.contentsScale: " + "\(lineShape.contentsScale)")
        
        //continue here
            //return a tuple with (frameRect and pathRect)
            //Mimic the current RectUtil setup
        //support all the different left right top bottom etc.
        //write a note that you can optimize by storing halfsizes etc
        //test in the current element framework with a simple shape
        //the move on to do the same to round rect and circle and ellipse
        //add support for positioning
        //test with the tabbar example
        //move on
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
private class RectGraphicUtil {
    
    
    
    /**
     * Returns a Tuple with "frame and line rects" by offsetting @param rect with @param lineOffset
     * NOTE: works with different side offsetType (left,right,top,bottom)
     */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineRect:CGRect, frameRect:CGRect) {
        let topLeft = Utils.corner(rect, lineStyle,offsetType,Alignment.topLeft);//cornerPoint(rect, Alignment.TOP_LEFT, offsetType.left, offsetType.top, lineStyle);
        print("topLeft.frame: " + String(topLeft.frame));
        let bottomRight = Utils.corner(rect, lineStyle,offsetType,Alignment.bottomRight);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        print("bottomRight.frame: " + String(bottomRight.frame));
        func convert(tl:CGPoint,_ br:CGPoint)->CGRect{
            let x:CGFloat = tl.x;
            let y:CGFloat = tl.y;
            let width:CGFloat = br.x - tl.x;
            let height:CGFloat = br.y - tl.y;
            return CGRect(x, y, width, height);
        }
        let lineRect:CGRect = convert(topLeft.line,bottomRight.line)
        let frameRect:CGRect = convert(topLeft.frame,bottomRight.frame)
        return (lineRect,frameRect)
    }
    
}
private class Utils{
    /**
     * NOTE: only supports topLeft and bottomRight
     */
    class func corner(rect:CGRect,_ lineStyle:ILineStyle,_ offsetType:OffsetType,_ cornerType:String)->(line:CGPoint,frame:CGPoint){
        if(cornerType == Alignment.topLeft){
            let leftOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.left))
            let topOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.top))
            return (CGPoint(leftOffsetRect.lineRect.x,topOffsetRect.lineRect.y), CGPoint(leftOffsetRect.frameRect.x,topOffsetRect.frameRect.y))
        }else{/*bottomRight*/
            let bottomOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.bottom))
            let rightOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.right))
            bottomOffsetRect.frameRect[Alignment.bottomRight].distance(<#T##p: CGPoint##CGPoint#>)
            return (CGPoint(rightOffsetRect.lineRect.x,bottomOffsetRect.lineRect.y), )
        }
    }
    /**
     * Returns a Tuple with "frame and line rects" by offsetting @param rect with @param lineOffset
     * NOTE: only works when all sides are of the same offsetType
     */
    class func offsetRect(rect:CGRect, _ lineStyle:ILineStyle, _ offsetType:OffsetType)->(lineRect:CGRect, frameRect:CGRect) {
        var lineRect:CGRect = CGRect()
        var frameRect:CGRect = CGRect()
        let thickness:CGFloat = lineStyle.thickness
        if(offsetType == OffsetType(OffsetType.center)){/*Asserts if all props of the lineOffsetType is of the center type*/
            frameRect = rect.outset(thickness/2, thickness/2)/*frame*/
            lineRect = CGRect(0,0,rect.width,rect.height) + CGPoint(thickness/2, thickness/2)
        }else if(offsetType == OffsetType(OffsetType.inside)){/*inside*/
            frameRect = rect/*frame*/
            lineRect = CGRect(0,0,rect.width,rect.height).inset(thickness/2, thickness/2) /*line*/
        }else{/*outside*/
            frameRect = rect.outset(thickness, thickness) /*frame*/
            lineRect = CGRect(thickness/2,thickness/2,rect.width+thickness,rect.height+thickness)/*line, you expand the rect in the 0,0 coordinatespace*/
        }
        return (lineRect,frameRect)
    }
}