import Cocoa
@testable import Utils
@testable import Element

class ScrollVList:VList,Scrollable2{
    /**
     *
     */
    override open func scrollWheel(with event: NSEvent) {
        //Swift.print("ScrollVList.scrollWheel")
        scroll(event)
        //super.scrollWheel(with: event)
    }
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("ScrollVList.onScrollWheelChange")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("ScrollVList.setProgress progress: \(progress)")
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
        
    }
}
