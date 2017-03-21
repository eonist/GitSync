import Cocoa
@testable import Utils
@testable import Element
//slide with momentum (Try to use the momentum delta for velocity!?!?)
//magnetic points. Or friction slows down but stops applying friction unitl the value is (value % space) == 0 at which point it stops
    //SnapFriction is friction with a assert modulo compoent

//Make a test where you press a button that launch a ball at 60px per sec with Friction applied. 
    //then you add the snafriction

//You need: 
    //1. ball, 
    //2. lines that indicates marks to snap to. 
    //3. a button to launch the ball
class Graph4:Element {
    var mover:Friction?
    override func resolveSkin() {
        StyleManager.addStyle("Graph4{float:left;clear:left;}")
        super.resolveSkin()
        
        StyleManager.addStyle("Button#launch{float:left;clear:left;}")
        let btn:Button = addSubView(Button(64,24,self,"launch"))
   
        var toggle:Bool = true
        func onBtnClick(event:Event){
            if(event == ButtonEvent.upInside){
                Swift.print("onBtnClick")
                toggle ? mover!.start() : mover!.stop()
                toggle = !toggle
            }
        }
        btn.event = onBtnClick
        
        let ball = EllipseGraphic(0,75,25,25,FillStyle(NSColor.blue))
        _ = addSubView(ball.graphic)
        ball.draw()
        /*Anim*/
        func onFrameTick(_ value:CGFloat){
            ball.graphic.point.x = value
        }
        mover = Friction(Animation.sharedInstance,onFrameTick, 0,10,0.96)
        
        (0..<10).forEach{
            let i = $0
            let x:CGFloat = 50 * i
            let y:CGFloat = 100
            let y2:CGFloat = 120
            let p1:CGPoint = CGPoint(x,y)
            let p2:CGPoint = CGPoint(x,y2)
            let line:LineGraphic = LineGraphic(p1,p2,LineStyle(1,NSColor.orange))
            _ = addSubView(line.graphic)
            line.draw()
        }
    }
}
