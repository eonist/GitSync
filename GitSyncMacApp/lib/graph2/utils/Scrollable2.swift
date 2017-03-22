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
        Swift.print("Scrollable2.scroll() \(event.phase.type)")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit()
            case NSEventPhase.cancelled:onScrollWheelExit()
            case NSEventPhase(rawValue:0):onScrollWheelChange(event)
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
