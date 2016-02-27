import Foundation

class VerticalThrowArea :FlippedView{
    var mover:Friction?
    var timer:NSTimer?
    var startTime:CFAbsoluteTime?
    var elapsedTime:CFAbsoluteTime?
    var lastPos:CGPoint?
    
    init(){
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        let frictionValue:CGFloat = 0;
        self.mover = Friction(self,frictionValue,0,0.98)
        //self.timer = NSTimer(100,Int.MAX_VALUE)
        super.init(frame: <#T##NSRect#>)
    }

    
        
    
    func onTimer(timer: NSTimer) {
        let theStringToPrint = timer.userInfo as! String
        Swift.print(theStringToPrint)
        //print("ontimer")
        
        self.elapsedTime = CFAbsoluteTimeGetCurrent() - self.startTime!
        
        self.lastPos = localPos()
    }
    func startSettingTime(){//100ms
        self.startTime = CFAbsoluteTimeGetCurrent() ;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "onTimer:", userInfo: nil, repeats: false)
    }
    func stopSettingTime(){
        if(timer != nil){timer!.invalidate()}
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//