import Cocoa
@testable import Element
@testable import Utils

protocol Scrollable2:Containable2 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

extension Scrollable2{
    func scroll(_ event:NSEvent){
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit();
            case NSEventPhase.cancelled:onScrollWheelExit();
            case NSEventPhase(rawValue:0):onScrollWheelChange(event);
            default:break;
        }
    }
}
