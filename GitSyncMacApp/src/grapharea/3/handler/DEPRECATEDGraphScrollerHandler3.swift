import Cocoa
@testable import Utils
@testable import Element
//Continue here: 🏀
    //when you have it, try adding the bouncy anim 👈
    //clean up things
    //then trottle the fastList to FPS 🚫
    //

class GraphScrollerHandler3:ElasticScrollerFastListHandler,GraphScrollerDecorator3{
    override func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        guard dir == .hor else {return}
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        setProgressVal(p.x,.hor)
        frameTick()
    }
}

