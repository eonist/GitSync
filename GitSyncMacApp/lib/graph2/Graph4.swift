import Foundation
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
    override func resolveSkin() {
        super.resolveSkin()
        
        //StyleManager.addStyle("Button#launch{fill:green;}")
        let btn:Button = addSubView(Button(64,24,self,"launch"))
        
        func onBtnClick(event:Event){
            Swift.print("onBtnClick")
        }
        btn.event = onBtnClick
    }
}
