import Cocoa

class GraphicsTest:Graphic{
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
        let offsetType:OffsetType = OffsetType()
        offsetType.top = OffsetType.outside
        offsetType.bottom = OffsetType.center
        offsetType.left = OffsetType.center
        offsetType.right = OffsetType.center
        super.init(FillStyle(NSColor.yellowColor().alpha(0.5)),LineStyle(50,NSColor.blueColor().alpha(0.5)),offsetType)
        
        //frame = NSRect(x: x,y: y,width: width,height: height)
        //self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //needsDisplay = true;
        //Swift.print("graphics: " + String(graphics.context))
        
        //a.masksToBounds = false
        
        let rect:CGRect = CGRect(100,100,200,200)
        
        fillShape.path = CGRect(0,0,rect.width,rect.height).path/*Draws in the local coordinate space of the shape*/
        fillShape.frame = rect/*,position and set the size of the frame*/
        fillShape.display()
        //alignStroke(self)
        let offsetRects = RectGraphicUtil.offsetRect(fillShape.frame, lineShape.lineStyle!, lineOffsetType)
        lineShape.frame = offsetRects.frameRect
        lineShape.path = offsetRects.lineRect.path
        lineShape.display()/*draw the lineShape*/
        
        
        //continue here
            //return a tuple with (frameRect and pathRect)
            //Mimic the current RectUtil setup
        //support all the different left right top bottom etc.
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
        print("topLeft.line: " + String(topLeft.line));
        let bottomRight = Utils.corner(rect, lineStyle,offsetType,Alignment.bottomRight);//cornerPoint(rect, Alignment.BOTTOM_RIGHT, offsetType.right, offsetType.bottom, lineStyle);
        print("bottomRight.frame: " + String(bottomRight.frame));
        print("bottomRight.line: " + String(bottomRight.line));
        let frameRect:CGRect = Converter.convert(topLeft.frame,bottomRight.frame)
        let lineRect:CGRect = Converter.convert(topLeft.line,bottomRight.line)
        return (lineRect,frameRect)
    }
}
private class Converter{
    /**
     *
     */
    class func convertSpace(from:CGRect, _ to:CGRect)->CGRect{
        return 
    }
    /**
     * Converts topLeft corner and topRight corner to a CGRect instance
     */
    class func convert(tl:CGPoint,_ br:CGPoint)->CGRect{
        let x:CGFloat = tl.x;
        let y:CGFloat = tl.y;
        let width:CGFloat = br.x - tl.x;
        let height:CGFloat = br.y - tl.y;
        return CGRect(x, y, width, height);
    }
}
private class Utils{
    /**
     * NOTE: only supports topLeft and bottomRight
     * TODO: This code isnt Optimized, to optimize see the old code. (Requires individual side calculation and also some sides use the same math so some sides can be squasehd etc. Also reuse similar math etc) you can optimize by storing halfsizes etc
     */
    class func corner(rect:CGRect,_ lineStyle:ILineStyle,_ offsetType:OffsetType,_ cornerType:String)->(line:CGPoint,frame:CGPoint){
        if(cornerType == Alignment.topLeft){
            let topOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.top))
            let leftOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.left))
            return (CGPoint(leftOffsetRect.lineRect.x,topOffsetRect.lineRect.y), CGPoint(leftOffsetRect.frameRect.x,topOffsetRect.frameRect.y))
        }else{/*bottomRight*/
            let bottomOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.bottom))
            let rightOffsetRect = offsetRect(rect, lineStyle, OffsetType(offsetType.right))
            return (CGPoint(rightOffsetRect.lineRect.bottomRight.x,bottomOffsetRect.lineRect.bottomRight.y), CGPoint(rightOffsetRect.frameRect.bottomRight.x,bottomOffsetRect.frameRect.bottomRight.y))
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