import Cocoa
/**
 * @param parent: parent is needed so that we can add tracking areas to it. 
 * NOTE: Why do we add tracking areas to the parent: because all mouseenter / exit mousemoved should be handled by the element not the skin
 */
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
            let subView = self.subviews[i]
            let hitView = subView.hitTest(aPoint)/*if true then a point was found within its hittable area*/
            if(hitView != nil){return hitView}
        }
        return nil/*if no hitView is found return nil, the parent hitTest will then continue its search through its siblings etc*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//try a trackingView were the owner is always the parent. WHy because adding interactivity to Graphic isnt such a good idea, as graphic may one day be pure CALayer, or you could just create a dedicated CALAyer graphic clas?
//and add the trackingarea to the updatetrackingareas method see if it works. Also use bounds