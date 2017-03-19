import Cocoa
@testable import Element
@testable import Utils
protocol Scrollable2:Containable2 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

