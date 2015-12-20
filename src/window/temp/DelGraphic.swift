import Cocoa

class DelGraphic:FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override var wantsUpdateLayer:Bool {return true}//true enables the updateLayer to
    override init(frame frameRect: NSRect) {
        Swift.print("init")
        super.init(frame: frameRect)
        layer = TempCALayer()
        self.wantsLayer = true
        layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay//this is new, but apple recomends it, more about it here: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreAnimation_guide/SettingUpLayerObjects/SettingUpLayerObjects.html#//apple_ref/doc/uid/TP40004514-CH13-SW4
        
        //layer?.display()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override func drawRect(dirtyRect: NSRect) {
    Swift.print("TempNSView.drawRect()")
    let graphicsContext = NSGraphicsContext.currentContext()!
    let context = graphicsContext.CGContext/* Get the handle to the current context */
    let color = NSColor.redColor()
    let path:CGMutablePathRef  = CGPathCreateMutable();
    let rectangle:CGRect = CGRectMake(0.0, 0.0, 150.0, 150.0);
    CGPathAddRect(path,nil, rectangle);
    CGContextDrawPath(context, CGPathDrawingMode.Fill);
    CGContextAddPath(context,path)
    CGContextSaveGState(context)
    //CGContextStrokePath(context)
    CGContextSetFillColorWithColor(context,color.CGColor)
    CGContextDrawPath(context, CGPathDrawingMode.Fill)
    CGContextRestoreGState(context);
    }
    */
}