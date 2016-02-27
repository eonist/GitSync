import Cocoa

class VerticalThrowArea:InteractiveView2{
    var w:CGFloat = 200
    var h:CGFloat = 200
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
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x555555).alpha(0.5))
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
        Swift.print("mDown")
        startTime = CFAbsoluteTimeGetCurrent()
        mover!.slowDownFriction = 0.70//TODO: this needs to be more immediate
        tick();//init the first tick, the timer wont do this
        //_mover.stopMoving(null);
        
        CVDisplayLinkStop((self.superview as! AnimatableView).displayLink)//stop the frameTicker here
        
        startTimer()
        onDownPos = localPos()/*temporary store the mouse location, we need this when calculating the offset when dragging*/
        onDownMoverVal = mover!.value/*temporary store the mover value, we need this when calculating the offset when dragging*/
    }
    /**
     * TODO: If you hold the mouse in the same position for a fraction of time then dont calculate the movment distance. Just just stop the animation. Think how this would work in the real world
     */
    override func mouseUp(event: MouseEvent) {
        Swift.print("mUp")
        mover!.slowDownFriction = 1/*reset the slowDownFriction, 1 equals inactive*/
        //checkTime(this);/*calcs the speed aka the velocity and starts the anim in this speed*/
        let velocity = Utils.velocity(Utils.duration(startTime!,lastTime!), localPos().y - lastPos!.y)
        Swift.print("velocity: " + "\(velocity)")
        mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity*/
        
        CVDisplayLinkStart((self.superview as! AnimatableView).displayLink)//'start the frameTicker here
        stopTimer()/*stops the timer that was started onMouseDown*/
    }
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("mDragged")
        //mover.stopMoving(nil);/*Stop the mover*///TODO:this should not be called on every move call, make a bool,also stop the frameTimer instance not the mover it self, or?
        mover!.value = onDownMoverVal! + (localPos().y - onDownPos!.y)/*manipulate the value of the mover with the vaue of the y pos of the mouse directly*/
    }
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
        let calcA:CGFloat = distance/(CGFloat(duration)/1000)/*divide milliseconds by thousand to get seconds*/
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