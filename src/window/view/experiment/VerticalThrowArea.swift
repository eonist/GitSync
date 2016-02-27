import Cocoa

class VerticalThrowArea:InteractiveView2{
    var mover:Friction?
    var timer:NSTimer?
    var startTime:CFAbsoluteTime?
    var elapsedTime:CFAbsoluteTime?
    var lastPos:CGPoint?
    var timeMark:CFAbsoluteTime?
    
    init(){
        let frictionValue:CGFloat = 0;
        super.init(frame: NSRect(0,0,320,480))
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        self.mover = Friction(self,frictionValue,0,0.98)
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*Rect*/
        let rect = RectGraphic(0,0,320,480,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        //rect.graphic.frame.y = 60
        
    }
    func onTimer(timer: NSTimer) {
        let theStringToPrint = timer.userInfo as! String
        Swift.print(theStringToPrint)
        //print("ontimer")
        
        //self.elapsedTime = CFAbsoluteTimeGetCurrent() - self.startTime!
        
        self.lastPos = localPos()
    }
    func startSettingTime(){//100ms
        self.startTime = CFAbsoluteTimeGetCurrent() ;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "onTimer:", userInfo: nil, repeats: false)
    }
    func stopSettingTime(){
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
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//