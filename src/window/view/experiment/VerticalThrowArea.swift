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
    func stopTimeer(){
        if(timer != nil){timer!.invalidate()}
    }
    /*
     * Calculates the dist and duration of the "mouse-throw"
     */
    func checkTime(throwArea:VerticalThrowArea)->(Double,CGFloat){
        let elapsedTime = CFAbsoluteTimeGetCurrent() - self.startTime!/*elapsed time since begining*/
        let duration:Double = elapsedTime - timeMark!/*elapsed time since mouse-down*/
        let distance:CGFloat = localPos().y - lastPos!.y;
        //trace("x distance Since click"+(distance));
        //trace("timeSince click"+(duration));
        //return velocity(throwArea,duration,distance);
        return (duration:duration,distance:distance)
    }
    /*
     * Uses the dist and duration of the mouse-throw to calculate the speed, aka the velocity. THen starts the animation in this speed aka velocity.
     */
    func velocity(duration:Double,_ distance:CGFloat,_ frameRate:CGFloat = 60) -> CGFloat{
        let calcA:CGFloat = distance/(CGFloat(duration)/1000)/*divide milliseconds by thousand to get seconds*/
        let calcB:CGFloat = calcA/frameRate
        return calcB;
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
        
        //continue here
        
    }
    override func mouseUp(event: MouseEvent) {
        Swift.print("mUp")
    }
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("mDragged")
        //mover.stopMoving(nil);/*Stop the mover*///TODO:this should not be called on every move call, make a bool,also stop the frameTimer instance not the mover it self, or?
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//