import Cocoa
@testable import Element
@testable import Utils
protocol Scrollable2:Containable2 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

extension ContainerView2:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)
            case NSEventPhase.mayBegin:onScrollWheelEnter()
            case NSEventPhase.began:onScrollWheelEnter()
            case NSEventPhase.ended:onScrollWheelExit();
            case NSEventPhase.cancelled:onScrollWheelExit();
            default:break;
        }
        super.scrollWheel(with: event)
    }
}

extension Scrollable2{
    func onScrollWheelEnter(){/*fatalError("must be overriden")*/}
    func onScrollWheelExit(){/*fatalError("must be overriden")*/}
    func onScrollWheelChange(_ event:NSEvent){fatalError("must be overriden")}
}
