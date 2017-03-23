import Cocoa
@testable import Element
@testable import Utils

protocol Scrollable2:Containable2 {
    /**/func onScrollWheelChange(_ event:NSEvent)
     func onScrollWheelEnter()
     func onScrollWheelExit()
 
}

extension Scrollable2{
    func scroll(_ event:NSEvent){
        Swift.print("Scrollable2.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Direct scroll*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit()
            case NSEventPhase.cancelled:onScrollWheelExit()
            case NSEventPhase(rawValue:0):onScrollWheelChange(event)/*this is the same as momentum aka inDirect scroll*/
            default:break;
        }
    }
    /*func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
     Swift.print("📜 Scrollable2.onScrollWheelChange: \(event.type)")
     }
     func onScrollWheelEnter() {
     Swift.print("📜 Scrollable2.onScrollWheelEnter()")
     }
     func onScrollWheelExit() {
     Swift.print("📜 Scrollable2.onScrollWheelExit()")
     }*/
}
