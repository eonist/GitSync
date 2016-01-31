import Cocoa

class WinView5:FlippedView {
    var viewA:NSView!
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        Swift.print("init")
        hitTesting()
    }
    /**
     *
     */
    func hitTesting(){
        Swift.print("hitTesting")
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        viewA = ViewA(1,1)
        addSubView(viewA)
        
        //add a redbox in a view inside the blue view (100x100)
        
        //offset the redbox view a bit so that the entire bounds of the hirarchy becomes 150
        
        //then test what the bound is on view 1
    }
}
private class ViewA:FlippedView{
    var viewB:NSView!
    private override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    override var acceptsFirstResponder:Bool{return true}
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        /*let trackingArea:NSTrackingArea = NSTrackingArea(rect: bounds, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)*/
        createContent()
    }
    /**
     *
     */
    func createContent(){
        Swift.print("ViewA create content")
        let blueBox = RectGraphic(200,200,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
        //blueBox.graphic.frame.origin = CGPoint(50,50)
        
        viewB = ViewB(200,200)
        addSubview(viewB)
        viewB.frame.origin = CGPoint(50,50)/**/
    }
    override func hitTest(aPoint: NSPoint) -> NSView? {
        Swift.print("hit")
        //Swift.print("ViewA aPoint: " + "\(aPoint)")
        viewB.hitTest(aPoint)
        return self
    }
    /*override func mouseDown(theEvent: NSEvent) {
    Swift.print("ViewA.mouseDown() theEvent: " + "\(theEvent)")
    //Swift.print("window?.mouseLocationOutsideOfEventStream: " + "\(window?.mouseLocationOutsideOfEventStream)")
    //let theHitView = window!.contentView?.hitTest((window?.mouseLocationOutsideOfEventStream)!)
    //Swift.print("theHitView: " + "\(theHitView)")
    }/**/*/
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

private class ViewB:FlippedView{
    
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        let trackingArea:NSTrackingArea = NSTrackingArea(rect: NSRect(0,0,200,200), options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
        
        createContent()
    }
    private override func mouseMoved(theEvent: NSEvent) {
        Swift.print("move")
    }
    /**
     *
     */
    func createContent(){
        Swift.print("ViewB create content")
        let redBox = RoundRectGraphic(0,0,200,200,Fillet(50),FillStyle(NSColor.redColor()),LineStyle(5,NSColor.greenColor()),OffsetType(OffsetType.center))
        addSubview(redBox.graphic)
        redBox.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
    }
    override func hitTest(aPoint: NSPoint) -> NSView? {
        Swift.print("ViewB.hitTest() point: " + "\(aPoint)")
        return self
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("ViewB.mouseDown()")
        //Swift.print("window?.mouseLocationOutsideOfEventStream: " + "\(window?.mouseLocationOutsideOfEventStream)")
        //let theHitView = window!.contentView?.hitTest((window?.mouseLocationOutsideOfEventStream)!)
        //Swift.print("theHitView: " + "\(theHitView)")
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}