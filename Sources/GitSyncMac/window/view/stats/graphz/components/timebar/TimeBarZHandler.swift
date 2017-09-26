import Cocoa
@testable import Utils
@testable import Element

class TimeBarZHandler:ElasticScrollerFastListHandler{ /*ElasticScrollerFastListHandler*/
    override func onScrollWheelChange(_ event: NSEvent) {
//        Swift.print("moverGroup.xMover.contentFrame: " + "\(moverGroup.xMover.contentFrame)")
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        //(self as ElasticScrollableFastListable3).setProgress(p)
        setProgressVal(p.x,.hor)
//        setProgressVal(p.y,.ver)
    }
}
