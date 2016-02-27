import Foundation

class VerticalThrowArea :FlippedView{
    var mover:Friction
    var timer:NSTimer?
    var startTime:CFAbsoluteTime?
    
    init(){
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        let frictionValue:CGFloat = 0;
        self.mover = Friction(self,frictionValue,0,0.98)
        //self.timer = NSTimer(100,Int.MAX_VALUE)
    }

    
        
    
    func onTimer(timer: NSTimer) {
        let theStringToPrint = timer.userInfo as! String
        print(theStringToPrint)
        //print("ontimer")
        
        //CFAbsoluteTimeGetCurrent()
        var duration:uint = getTimer()
        self.lastTime = duration
        self.lastPos = CGPoint(self.mouseX,self.mouseY)
    }
    func startSettingTime(){//100ms
        self.startTime = CFAbsoluteTimeGetCurrent() ;
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "onTimer:", userInfo: nil, repeats: false)
    }
    func stopSettingTime(){
        timer.invalidate()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//