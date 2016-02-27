import Foundation

class VerticalThrowArea :FlippedView{
    private var mover:Friction
    private var timer:Timer?
    init(){
        //var b1:Rect2 = addSubView(Rect2(_width,_height,FillStyle(Colors.GREEN,_alpha))) as Button
        var frictionValue:CGFloat = 0;
        self.mover = Friction(this,frictionValue,0,0.98)
        //self.timer = NSTimer(100,Int.MAX_VALUE)
    }
    func onTimer(timer: NSTimer) {
        let theStringToPrint = timer.userInfo as! String
        print(theStringToPrint)
        //print("ontimer")
        var duration:uint = getTimer()
        self.lastTime = duration
        self.lastPos = CGPoint(self.mouseX,self.mouseY)
    }
    func startSettingTime(){//100ms
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "onTimer:", userInfo: nil, repeats: false)
    }
    func stopSettingTime(){
        timer.invalidate()
    }
}

//CFAbsoluteTimeGetCurrent()