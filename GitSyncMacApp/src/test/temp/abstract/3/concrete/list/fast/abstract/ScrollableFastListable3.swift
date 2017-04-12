import Cocoa
@testable import Element
@testable import Utils

protocol ScrollableFastListable3:FastListable3,Scrollable3{}

extension ScrollableFastListable3{
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("ScrollableFastListable3.onScrollWheelChange()")
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        (self as FastListable3).setProgress(progressVal)
        (self as Scrollable3).setProgress(progressVal)
    }
}
