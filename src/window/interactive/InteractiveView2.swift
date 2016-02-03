import Cocoa
/**
 * IMPORTANT: To understand the relatioship between NSEvent and hitTest: think of NSEvent as going upStream in an inverted pyramid hirarachy and hitTest going downStream in the same hirarachy
 */
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
     * MouseMove (only fires when the mouse is actualy moving on the visible  part of the view)
     * NOTE: It could be possible to only call this method if a bool value was true. Optimization
     * TODO: when you implement propegation of the mouseMove method, mousemove needs a bool to turn it on or it will flood its parents with calls, isMouseMovable could be used
     */
    func mouseMove(/*event:MouseEvent*/){
        /*override in subclass*/
    }
    /**
     * Only fires if the mouse is over the visible part of this view 
     * NOTE: you have to implement a hitTest that aserts that the aPoint is within the path. (either in the CALayer or at the last hitTesable NSView in your stack)
     */
    func mouseOver(event:MouseEvent){
        if(self.superview is InteractiveView2){(self.superview as! InteractiveView2).mouseOver(event)}/*informs the parent that an event occured*/
    }
    /**
     * Only fires if the mouse is "rolls" out of the visible part of this view
     */
    func mouseOut(event:MouseEvent/**/){
        if(self.superview is InteractiveView2){(self.superview as! InteractiveView2).mouseOut(event)}/*informs the parent that an event occured*/
    }
    /**
     * MouseMoved
     * NOTE: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
     */
    override func mouseMoved(theEvent: NSEvent) {
        //Swift.print("InteractiveView.mouseMoved")
        if(hasMouseEntered){/*Only run the following code when inside the actual TrackingArea*/
            if(viewUnderMouse === self){//mouse move on the "visible" part of the view
                if(!isMouseOver){mouseOver(MouseEvent(theEvent,self));isMouseOver = true;}
                mouseMove()
            }
            else if(isMouseOver){mouseOut(MouseEvent(theEvent,self));isMouseOver = false;}//mouse move on the "invisible" parth of the view
        }
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
        //Swift.print("InteractiveView2.mouseEntered: event.locationInWindow" + "\(event.locationInWindow)")//+ "\(viewUnderMouse)" + " self: " + "\(self)"
        hasMouseEntered = true/*optimization*/
        if(viewUnderMouse === self){mouseOver(MouseEvent(event.locationInWindow,self));isMouseOver = true;}//mouse move on visible view
        //super.mouseEntered(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    /**
     * Fires when the mouse exits the tracking area, regardless if it is overlapping with other trackingAreas of other views
     * NOTE: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
     */
    override func mouseExited(event: NSEvent){
        //Swift.print("InteractiveView.mouseExited: event.locationInWindow: " + "\(event.locationInWindow)")
        hasMouseEntered = false/*optimization*/
        if(isMouseOver){mouseOut(MouseEvent(event.locationInWindow,self));isMouseOver = false;}
        //super.mouseExited(event)/*passes on the event to the nextResponder, NSView parents etc*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension InteractiveView2{
    /**
     * Returns a correctly flipped coordinate of the mouse in window space 0,0
     * @NOTE: there may be a problem with this if the window has a titleBar, then the height of this may need to be included
     */
    var winMousePos:CGPoint {
        var pos = (window?.mouseLocationOutsideOfEventStream)!//convertPoint((window?.mouseLocationOutsideOfEventStream)!, fromView: nil)/*converts the p to local coordinates*/
        pos.y = WindowParser.height(window!) - pos.y/*flips the window coordinates*/
        return pos
    }
    var viewUnderMouse:NSView?{
        let theHitView = window!.contentView?.hitTest((window?.mouseLocationOutsideOfEventStream)!)
        return theHitView
    }
}

class InteractionUtils{
    /**
     * This method finds the immediate origin. Aka the first descendant of current
     */
    func immediate(current:NSView,_ origin:NSView)->NSView{//origin may be a CALayer, test this later
        var view:NSView = origin
        while(view.superview != current) {
            view = view.superview!
        }
        return view;
    }
    /**
     * origin equals target or origin descendes from target
     * @param origin: the result of hitTest()
     * @param target: i.e button1 or slider or some other UI component.
     */
    func withinScope(origin:NSView,_ target:NSView)->Bool{
        return origin === target || origin.isDescendantOf(target)
    }
}

