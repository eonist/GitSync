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
        
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x555555).alpha(0.0))
        /*Rect*/
        let rect = RectGraphic(0,0,w,h,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()

    }
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
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
        }else if(theEvent.phase == NSEventPhase.MayBegin){//can be used to detect if two fingers are touching the trackpad
            //Swift.print("MayBegin")
            onScrollWheelDown()
        }else if(theEvent.phase == NSEventPhase.Ended){//if you release your touch-gesture and the momentum of the gesture has stopped.
            //Swift.print("Ended ")
            onScrollWheelUp()
            //dont start the CVDisplayLink, since your momentum has stopped
        }else if(theEvent.phase == NSEventPhase.Cancelled){
            //Swift.print("Cancelled")
            onScrollWheelUp()
        }
        super.scrollWheel(theEvent)//call super to forward the event to the parent view
    }
    func onScrollWheelDown(){
        //Swift.print("onScrollWheelDown")
        prevScrollingDeltaY = 0
        velocities = [0,0,0,0,0,0,0,0,0,0]//reset the velocities
        mover!.slowDownFriction = 0.40//set this to 0.70 and the slowdown prosses is slower
    }
    func onScrollWheelUp(){
        //Swift.print("onScrollWheelUp " + "\(prevScrollingDeltaY)")
        mover!.slowDownFriction = 1/*reset the slowDownFriction, 1 equals inactive*/
        mover!.hasStopped = false/*reset this value to false*/
        //checkTime(this);/*calcs the speed aka the velocity and starts the anim in this speed*/
        if(prevScrollingDeltaY != 1.0 && prevScrollingDeltaY != -1.0){/*1 and -1 indicates stationaryness*/
            //Swift.print("is not stationary")
            var velocity:CGFloat = 0
            if(prevScrollingDeltaY > 0){
                velocity = NumberParser.max(velocities)
            }else{
                velocity = NumberParser.min(velocities)
            }
            mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity*/
            CVDisplayLinkStart((self.superview as! AnimatableView).displayLink)//'start the frameTicker here, do this part in parent view or use event or Selector
        }else{
            //Swift.print("is stationary")
        }
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
