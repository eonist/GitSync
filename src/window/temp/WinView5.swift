import Cocoa

class WinView5:FlippedView {
    var viewA:ViewA!
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
        viewA = ViewA(00,00)
        addSubView(viewA)
    }
    /*override func hitTest(aPoint: NSPoint) -> NSView? {
    return viewA.hitTest(aPoint)
    }*/
}
class ViewA:InteractiveView2{
    var viewB:ViewB!
    //override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        //return true
    //}
    //override internal var acceptsFirstResponder:Bool{return true}
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
        
        viewB = ViewB(00,00)
        viewB.frame.origin = CGPoint(50,50)/**/
        addSubview(viewB)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ViewB:InteractiveView2{
    //override internal var acceptsFirstResponder:Bool{return true}
    var redBox:RoundRectGraphic?
    
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        let trackingArea:NSTrackingArea = NSTrackingArea(rect: NSRect(0,0,200,200), options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
        createContent()
    }
    override func mouseMoved(theEvent: NSEvent) {
        Swift.print("move b")
    }
    /**
     *
     */
    func createContent(){
        Swift.print("ViewB create content")
        redBox = RoundRectGraphic(0,0,200,200,Fillet(50),FillStyle(NSColor.redColor()),LineStyle(5,NSColor.greenColor()),OffsetType(OffsetType.center))
        addSubview(redBox!.graphic)
        redBox!.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
        
        //let win = self.window!
        /*
        NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDownMask, .RightMouseDownMask], handler: { (event : NSEvent) -> NSEvent? in
            Swift.print("test " + "\(event)")
            //self.
            let theView = self.window!.contentView?.hitTest((self.window?.mouseLocationOutsideOfEventStream)!)
            Swift.print("theView: " + "\(theView)")
            return event
        })
        */
    }
    
    override func hitTest(aPoint: NSPoint) -> NSView? {
        //Swift.print("ViewB.hitTest() point: " + "\(aPoint)")
        //Swift.print("viewB nextResponder: " + "\(nextResponder)")
        return redBox!.graphic.hitTest(aPoint)//super.hitTest(aPoint)
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("ViewB.mouseDown()")
        super.mouseDown(theEvent)
        //Swift.print("window?.mouseLocationOutsideOfEventStream: " + "\(window?.mouseLocationOutsideOfEventStream)")
        //let theHitView = window!.contentView?.hitTest((window?.mouseLocationOutsideOfEventStream)!)
        //Swift.print("theHitView: " + "\(theHitView)")
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class InteractiveView2:FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
    }
    /**
     *
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        for view in self.subviews{
            let hitView = view.hitTest(aPoint)/*if true then a point was found within its hittable area*/
            if(hitView != nil){return hitView}
        }
        return nil/*if no hitView is found return nil, the parent hitTest will then continue its search through its siblings etc*/
    }
    override func mouseMoved(theEvent: NSEvent) {
        Swift.print("InteractiveView2.moved")
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("InteractiveView2.mouseDown() ")
        super.mouseDown(theEvent)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}