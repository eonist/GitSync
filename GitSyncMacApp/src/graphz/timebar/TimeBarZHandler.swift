import Cocoa
@testable import Utils
@testable import Element

class TimeBarHandler:ElasticScrollerFastListHandler{ /*ElasticScrollerFastListHandler*/
    override func onScrollWheelChange(_ event: NSEvent) {
        //        Swift.print("onScrollWheelChange")
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
        //        Swift.print("p: " + "\(p)")
        //        setProgress(p)
        progressable.contentContainer.layer?.position.x = p.x
    }
}
