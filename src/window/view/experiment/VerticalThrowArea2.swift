import Cocoa

class VerticalThrowArea2 :InteractiveView2{
    var w:CGFloat = 200
    var h:CGFloat = 200
    var mover:Friction?
    var prevScrollingDeltaY:CGFloat = 0
    var velocities:Array<CGFloat> = [0,0,0,0,0,0,0,0,0,0]
    init(){
        super.init(frame: NSRect(0,0,w,h))
        
        self.mover = Friction(self,0,0,0.98)
    }
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    override func scrollWheel(theEvent: NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        //Swift.print("scrollingDeltaY: " + "\(theEvent.scrollingDeltaY)")
        //Swift.print("velocities: " + "\(velocities)")
        if(theEvent.phase == NSEventPhase.Changed){//fires everytime there is direct scrollWheel gesture movment.
            //Swift.print("changed")
            if(!mover!.hasStopped){
                if(CVDisplayLinkIsRunning((self.superview as! AnimatableView).displayLink)) {CVDisplayLinkStart((self.superview as! AnimatableView).displayLink);mover!.hasStopped = true;}//the if clause is just a precausion
            }
            mover!.value += theEvent.scrollingDeltaY
            prevScrollingDeltaY = theEvent.scrollingDeltaY//needed to calc the velocity onScrollWheelUp
            
            velocities.removeLast()
            velocities = [theEvent.scrollingDeltaY] + velocities
        }
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
