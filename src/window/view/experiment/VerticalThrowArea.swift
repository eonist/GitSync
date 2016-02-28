import Cocoa

class VerticalThrowArea:InteractiveView2{
    var w:CGFloat = TestView3.w
    var h:CGFloat = TestView3.h
    var mover:Friction?
    var timer:NSTimer?
    var startTime:CFAbsoluteTime?
    var elapsedTime:CFAbsoluteTime?
    var lastPos:CGPoint?/*mouse position in last tick*/
    var lastTime:CFAbsoluteTime?/*Time in last tick*/
    //var timeMark:CFAbsoluteTime?
    var onDownPos:CGPoint?
    var onDownMoverVal:CGFloat?
    
    init(){
        let frictionValue:CGFloat = 0;
        super.init(frame: NSRect(0,0,w,h))
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        self.mover = Friction(self,frictionValue,0,0.98)
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x555555).alpha(0.0))
        /*Rect*/
        let rect = RectGraphic(0,0,w,h,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        
        //rect.graphic.frame.y = 60
    }
    func tick(/*timer: NSTimer*/) {
        ////let theStringToPrint = timer.userInfo as! String
        //Swift.print(theStringToPrint)
        Swift.print("tick")
        
        //self.elapsedTime = CFAbsoluteTimeGetCurrent() - self.startTime!
        self.lastTime = CFAbsoluteTimeGetCurrent() - startTime!/*basically set the elapsed time*/
        self.lastPos = localPos()
    }
    func startTimer(){//
        self.startTime = CFAbsoluteTimeGetCurrent()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.3/*<--100ms*/, target: self, selector: "tick", userInfo: nil, repeats: true)
    }
    func stopTimer(){
        if(timer != nil){timer!.invalidate()}
    }
    /**
     * TODO: If you hold the mouse in the same position for a fraction of time then dont calculate the movment distance. Just just stop the animation. Think how this would work in the real world
     */
    override func mouseDown(event: MouseEvent) {
        Swift.print("mouseDown")
        startTime = CFAbsoluteTimeGetCurrent()
        mover!.slowDownFriction = 0.70//TODO: this needs to be more immediate
        tick();//init the first tick, the timer wont do this
        //_mover.stopMoving(null);
        startTimer()
        onDownPos = localPos()/*temporary store the mouse location, we need this when calculating the offset when dragging*/
        onDownMoverVal = mover!.value/*temporary store the mover value, we need this when calculating the offset when dragging*/
    }
    /**
     * TODO: If you hold the mouse in the same position for a fraction of time then dont calculate the movment distance. Just just stop the animation. Think how this would work in the real world
     */
    override func mouseUp(event: MouseEvent) {
        Swift.print("mouseUp")
        mover!.slowDownFriction = 1/*reset the slowDownFriction, 1 equals inactive*/
        //checkTime(this);/*calcs the speed aka the velocity and starts the anim in this speed*/
        let velocity = Utils.velocity(Utils.duration(startTime!,lastTime!), localPos().y - lastPos!.y)
        Swift.print("velocity: " + "\(velocity)")
        mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity*/
        
        mover!.hasStopped = false/*reset this value to false*/
        CVDisplayLinkStart((self.superview as! AnimatableView).displayLink)//'start the frameTicker here, do this part in parent view or use event or Selector
        stopTimer()/*stops the timer that was started onMouseDown*/
    }
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("mouseDragged")
        //mover.stopMoving(nil);/*Stop the mover*///TODO:this should not be called on every move call, make a bool,also stop the frameTimer instance not the mover it self, or?
        mover!.value = onDownMoverVal! + (localPos().y - onDownPos!.y)/*manipulate the value of the mover with the vaue of the y pos of the mouse directly*/
        Swift.print("mover!.value: " + "\(mover!.value)")
        super.mouseDragged(theEvent)
    }
    var prevYDelta:CGFloat = 0
    /**
     * NOTE: you can use the event.deviceDeltaY to check which direction the gesture is moving in.
     */
    override func scrollWheel(theEvent: NSEvent) {
        
        if(theEvent.phase == NSEventPhase.Stationary || theEvent.momentumPhase == NSEventPhase.Stationary){
            Swift.print("BINGO")
        }
        Swift.print("theEvent.modifierFlags: " + "\(theEvent.modifierFlags)")
        
        
        //Swift.print("theEvent: " + "\(theEvent)")
        //Swift.print("scrollingDeltaY: " + "\(theEvent.scrollingDeltaY)")
        
        if(theEvent.phase == NSEventPhase.Changed){//fires everytime there is direct scrollWheel gesture movment.
            //Swift.print("changed")
            mover!.value += theEvent.scrollingDeltaY
            prevYDelta = theEvent.scrollingDeltaY//needed to calc the velocity onScrollWheelUp
        }else if(theEvent.phase == NSEventPhase.MayBegin){//can be used to detect if two fingers are touching the trackpad
            //Swift.print("MayBegin")
            //Swift.print("onScrollWheelDown")
            onScrollWheelDown()
        }else if(theEvent.phase == NSEventPhase.Began){//can be used to detect when the scroll began.
            //Swift.print("Began")
        }else if(theEvent.phase == NSEventPhase.None){//if you release your touch-gesture and the momentum of the gesture has not stopped.
            //Swift.print("None " + "\(theEvent.deltaY)")
            //Swift.print("theEvent.scrollingDeltaY: " + "\(theEvent.scrollingDeltaY)")
            
            //calculate the velocity based on lastTime and lastPos
            //set the momentum to the Mover instance
            //start the CVDisplayLink
            //
        }else if(theEvent.phase == NSEventPhase.Ended){//if you release your touch-gesture and the momentum of the gesture has stopped.
            Swift.print("Ended ")
            Swift.print("theEvent: " + "\(theEvent)")

            onScrollWheelUp()
            //dont start the CVDisplayLink, since your momentum has stopped
        }else if(theEvent.phase == NSEventPhase.Cancelled){
            //Swift.print("Cancelled")
            onScrollWheelUp()
        }
        
        
        super.scrollWheel(theEvent)//call super to forward the event to the parent view
    }
    func onScrollWheelDown(){
        Swift.print("onScrollWheelDown")
        mover!.slowDownFriction = 0.70//TODO: this needs to be more immediate
    }
    func onScrollWheelUp(){
        Swift.print("onScrollWheelUp " + "\(prevYDelta)")
        mover!.slowDownFriction = 1/*reset the slowDownFriction, 1 equals inactive*/
        //checkTime(this);/*calcs the speed aka the velocity and starts the anim in this speed*/
        mover!.velocity = prevYDelta/*set the mover velocity to the current mouse gesture velocity*/
        
        mover!.hasStopped = false/*reset this value to false*/
        CVDisplayLinkStart((self.superview as! AnimatableView).displayLink)//'start the frameTicker here, do this part in parent view or use event or Selector
    }
    
    //TODO: There is no way to check if when you onUp the scrollWheel that you 
    
    //TODO: the way you implement dual support for dragging and scrollwheel is that you call onUp and onDown and onDragging/onDirectManipulation
    
    //TODO: Implement a gesture algorithm that is more precis for the mouse throw. Or maybe you could just store the time and location for the last mouseMovement and then on mouseUp you take the time of the onUp and the loc of the on up and then calc the velocity
    
    //TODO: For the wheel velocity, use the first deltaY value that is fired right after the phase == Ended
   
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /*
     * Uses the dist and duration of the mouse-throw to calculate the speed, aka the velocity. THen starts the animation in this speed aka velocity.
     * PARAM distance: the dist of the mouse-throw
     * NOTE: it works by looking at the lastPos and lastTime from the last Tick
     */
    class func velocity(duration:Double,_ distance:CGFloat,_ frameRate:CGFloat = 60) -> CGFloat{
        Swift.print("distance: " + "\(distance)")
        Swift.print("duration: " + "\(duration)")
        let calcA:CGFloat = distance/(CGFloat(duration))/*divide milliseconds by thousand to get seconds*/
        let calcB:CGFloat = calcA/frameRate
        return calcB;
    }
    /**
     * Calculates the duration of the "mouse-throw"
     */
    class func duration(startTime:CFAbsoluteTime,_ lastTime:CFAbsoluteTime)->Double{
        Swift.print("startTime: " + "\(startTime)")
        Swift.print("CFAbsoluteTimeGetCurrent(): " + "\(CFAbsoluteTimeGetCurrent())")
        let elapsedTime = CFAbsoluteTimeGetCurrent() - startTime/*elapsed time since begining*/
        Swift.print("elapsedTime: " + "\(elapsedTime)")
        let duration:Double = elapsedTime - lastTime/*elapsed time since last tick*/
        //Swift.print("duration: " + "\(duration)")
        return duration
    }
}