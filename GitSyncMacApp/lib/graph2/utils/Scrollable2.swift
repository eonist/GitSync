import Cocoa
@testable import Element
@testable import Utils
protocol Scrollable2 {
    func onScrollWheelChange(_ event:NSEvent)
}

extension GraphView:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            default:break;
        }
        super.scrollWheel(with: event)
    }
}
