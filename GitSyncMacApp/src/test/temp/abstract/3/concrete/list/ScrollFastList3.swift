import Cocoa
@testable import Utils
func onScrollWheelChange(_ event: NSEvent) {
    
}

class ScrollFastList3:FastList3, ScrollableFastListable3{
    //continue here: make ScrollFastListable3, which overrides onChange. 
        //setProgress
}
protocol ScrollableFastListable3:FastListable3,Scrollable3{}
extension ScrollableFastListable3{
    func onScrollWheelChange(_ event: NSEvent) {
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        (self as FastListable3).setProgress(progressVal)
        (self as Scrollable3).setProgress(progressVal)
    }
}
