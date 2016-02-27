import Cocoa

class VerticalThrowArea:InteractiveView2{
    var w:CGFloat = 200
    var h:CGFloat = 200
    var mover:Friction?
    var timer:NSTimer?
    var startTime:CFAbsoluteTime?
    var elapsedTime:CFAbsoluteTime?
    var lastPos:CGPoint?
    var timeMark:CFAbsoluteTime?
    var onDownPos:CGPoint?
    var onDownMoverVal:CGFloat?
    
    init(){
        let frictionValue:CGFloat = 0;
        super.init(frame: NSRect(0,0,w,h))
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        self.mover = Friction(self,frictionValue,0,0.98)
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*Rect*/
        let rect = RectGraphic(0,0,w,h,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        //rect.graphic.frame.y = 60
        
    }
    func tick(/*timer: NSTimer*/) {
        ////let theStringToPrint = timer.userInfo as! String
        //Swift.print(theStringToPrint)
        //print("ontimer")
        
        //self.elapsedTime = CFAbsoluteTimeGetCurrent() - self.startTime!
        
        //self.lastPos = localPos()
    }
    func startTimer(){//
        self.startTime = CFAbsoluteTimeGetCurrent() ;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01/*<--100ms*/, target: self, selector: "onTimer:", userInfo: nil, repeats: false)
    }
    func stopTimer(){
        if(timer != nil){timer!.invalidate()}
    }
    /**
     * TODO: If you hold the mouse in the same position for a fraction of time then dont calculate the movment distance. Just just stop the animation. Think how this would work in the real world
     */
    override func mouseDown(event: MouseEvent) {
        Swift.print("mDown")
        mover!.slowDownFriction = 0.70//TODO: this needs to be more immediate
        //tick();//init the first tick, the timer wont do this
        //_mover.stopMoving(null);
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
        let velocity = Utils.velocity(Utils.duration(startTime!,timeMark!), localPos().y - lastPos!.y)
        mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity*/
        //TODO:start the frameTicker here
        stopTimer()/*stops the timer that was started onMouseDown*/
    }
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("mDragged")
        //mover.stopMoving(nil);/*Stop the mover*///TODO:this should not be called on every move call, make a bool,also stop the frameTimer instance not the mover it self, or?
        mover.value = (aEvent.localY-_mouseMovePos.y + _mouseMovePos.curMoverValue);/*manipulate the value of the mover with the vaue of the y pos of the mouse directly*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /*
     * Uses the dist and duration of the mouse-throw to calculate the speed, aka the velocity. THen starts the animation in this speed aka velocity.
     * PARAM distance: the dist of the mouse-throw
     */
    class func velocity(duration:Double,_ distance:CGFloat,_ frameRate:CGFloat = 60) -> CGFloat{
        let calcA:CGFloat = distance/(CGFloat(duration)/1000)/*divide milliseconds by thousand to get seconds*/
        let calcB:CGFloat = calcA/frameRate
        return calcB;
    }
    /**
     * Calculates the duration of the "mouse-throw"
     */
    class func duration(startTime:CFAbsoluteTime,_ timeMark:CFAbsoluteTime)->Double{
        let elapsedTime = CFAbsoluteTimeGetCurrent() - startTime/*elapsed time since begining*/
        let duration:Double = elapsedTime - timeMark/*elapsed time since mouse-down*/
        return duration
    }
   
}
//