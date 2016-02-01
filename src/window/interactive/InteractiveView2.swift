import Cocoa

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
