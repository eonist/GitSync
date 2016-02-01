import Cocoa

class WinView5:FlippedView {
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
    func hitTesting(){
        Swift.print("hitTesting")
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        let viewA:ViewA = ViewA(00,00)
        addSubView(viewA)
    }
}
class ViewA:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewA create content")
        let skin = SkinA(NSRect(0,0,200,200),self)
        addSubview(skin)
        
        let viewB:ViewB! = ViewB(00,00)
        viewB.frame.origin = CGPoint(50,50)/**/
        addSubview(viewB)
    }
    override func mouseEntered(event: NSEvent) {
        //Swift.print("ViewA.mouseEntered()")
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent) {
        //Swift.print("ViewA.mouseExited()")
        super.mouseExited(event)
    }
    override func mouseOver() {
        Swift.print("ViewA.mouseOver() ")
        super.mouseOver()
    }
    override func mouseOut() {
        Swift.print("ViewA.mouseOut() ")
        super.mouseOut()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ViewB:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewB create content")
        let skin = SkinB(NSRect(0,0,200,200),self)
        addSubview(skin)
    }
    override func mouseEntered(event: NSEvent) {
        //Swift.print("ViewB.mouseEntered()")
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent) {
        //Swift.print("ViewB.mouseExited()")
        super.mouseExited(event)
    }
    override func mouseOver() {
        Swift.print("ViewB.mouseOver() ")
        super.mouseOver()
    }
    override func mouseOut() {
        Swift.print("ViewB.mouseOut() ")
        super.mouseOut()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class InteractiveView2:FlippedView{
    var isMouseOver:Bool = false;/*you should hit test this on init*/
    var hasMouseEntered:Bool = false/*you should hit test this on init*/
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
    }
    /**
     * NOTE: looping backwards is very important as its the only way to target the front-most views in the stack
     * NOTE: why is this needed? because normal hitTesting doesnt work if the frame size is zero. or if a subView is outside the frame.
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        for var i = self.subviews.count-1; i > -1; --i{//<--you could store the count outside the loop for optimization, i dont know if this is imp in swift
            let view = self.subviews[i]
            let hitView = view.hitTest(aPoint)/*if true then a point was found within its hittable area*/
            if(hitView != nil){return view is TrackingView ? self : hitView}//<--if the view is a skin then return the self, so that the mouseEnter mouseExit methods work
        }
        return nil/*if no hitView is found return nil, the parent hitTest will then continue its search through its siblings etc*/
    }
    /**
     * Only fires if the mouse is over the visible part of this view
     */
    func mouseOver(){
        /*override in subclass*/
    }
    /**
     * Only fires if the mouse is "rolls" out of the visible part of this view
     */
    func mouseOut(){
        /*override in subclass*/
    }
    override func mouseMoved(theEvent: NSEvent) {
        //Swift.print("InteractiveView2.moved() " + "\(self.className)")
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("InteractiveView2.mouseDown() " + "\(self.className)")
        super.mouseDown(theEvent)
    }
    /**
     * Fires when the mouse enters the tracking area, regardless if it is overlapping with other trackingAreas of other views
     * NOTE: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
     */
    override func mouseEntered( event: NSEvent){
        //Swift.print("InteractiveView.mouseEntered: " )//+ "\(viewUnderMouse)" + " self: " + "\(self)"
        hasMouseEntered = true/*optimization*/
        if(viewUnderMouse === self){mouseOver();isMouseOver = true;}//mouse move on visible view
        super.mouseEntered(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Fires when the mouse exits the tracking area, regardless if it is overlapping with other trackingAreas of other views
     * NOTE: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
     */
    override func mouseExited(event: NSEvent){
        //Swift.print("InteractiveView.mouseExited:")
        hasMouseEntered = false/*optimization*/
        if(isMouseOver){mouseOut();isMouseOver = false;}
        super.mouseExited(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//continue here: the quetion is does the parent recieve over when a child recieves over? and what are the implications of this?


extension InteractiveView2{
    /**
     * Returns a correctly flipped coordinate of the mouse in window space 0,0
     */
    var winMousePos:CGPoint {
        var pos = (window?.mouseLocationOutsideOfEventStream)!//convertPoint((window?.mouseLocationOutsideOfEventStream)!, fromView: nil)/*converts the p to local coordinates*/
        pos.y = window!.frame.height - pos.y/*flips the window coordinates*/
        return pos
    }
    var viewUnderMouse:NSView?{
        let theHitView = window!.contentView?.hitTest((window?.mouseLocationOutsideOfEventStream)!)
        return theHitView
    }
}

//Continue here: Create a class that has a graphic and a trackingframe and also gets its parent in the init

class SkinA:TrackingView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(_ frameRect:NSRect,_ parent:NSView) {
        super.init(frameRect, parent)
        createContent()
    }
    func createContent(){
        let blueBox = RectGraphic(200,200,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
        //blueBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class SkinB:TrackingView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(_ frameRect:NSRect,_ parent:NSView) {
        super.init(frameRect, parent)
        createContent()
    }
    func createContent(){
        let redBox:RoundRectGraphic = RoundRectGraphic(0,0,200,200,Fillet(50),FillStyle(NSColor.redColor()),LineStyle(5,NSColor.greenColor()),OffsetType(OffsetType.center))
        addSubview(redBox.graphic)
        redBox.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class TrackingView:FlippedView{//rename to TrackingView?
    var trackingArea:NSTrackingArea
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    init(_ frameRect:NSRect,_ parent:NSView) {
        trackingArea = NSTrackingArea(rect: frameRect, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: parent, userInfo: nil)
        super.init(frame: frameRect)
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        addTrackingArea(trackingArea)//<---this will be in the Skin class in the future and the owner will be set to Element to get interactive events etc
    }
    /**
     * NOTE: looping backwards is very important as its the only way to target the front-most views in the stack
     * NOTE: why is this needed? because normal hitTesting doesnt work if the frame size is zero. or if a subView is outside the frame.
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        for var i = self.subviews.count-1; i > -1; --i{//<--you could store the count outside the loop for optimization, i dont know if this is imp in swift
            let view = self.subviews[i]
            let hitView = view.hitTest(aPoint)/*if true then a point was found within its hittable area*/
            if(hitView != nil){return hitView}
        }
        return nil/*if no hitView is found return nil, the parent hitTest will then continue its search through its siblings etc*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}




//continue here: aswell as rollOver rollOut etc, test with 2 subSkins and make TrackingView

//try to change the size of the trackingframe aswell




