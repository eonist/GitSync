import Cocoa
@testable import Utils
@testable import Element

class ScrollList2:List2,Scrollable2{
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("ScrollVList.onScrollWheelChange")
        let progressVal:CGFloat = SliderListUtils.progress(event.delta[dir], interval, progress)
        setProgress(progressVal)
    }
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("ScrollVList.setProgress progress: \(progress)")
        Swift.print("contentSize: " + "\(contentSize)")
        let val:CGFloat = ScrollableUtils.scrollTo(progress, maskSize[dir], contentSize[dir])
        Swift.print("val: " + "\(val)")
        contentContainer!.point[dir] = val
    }
}
