import Cocoa
@testable import Utils
@testable import Element

protocol Scrollable3:Progressable3 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}
extension Scrollable2{
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
        //Swift.print("Scrollable2.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Direct scroll*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit()//always exits with event with no delta
            case NSEventPhase.cancelled:onScrollWheelExit()//always exits with event with no delta
            case NSEventPhase(rawValue:0):onScrollWheelChange(event)/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            default:break;
        }
    }
    func onScrollWheelChange(_ event:NSEvent) {}/*Direct scroll, not momentum*/
    func onScrollWheelEnter() {}
    func onScrollWheelExit() {}
}
