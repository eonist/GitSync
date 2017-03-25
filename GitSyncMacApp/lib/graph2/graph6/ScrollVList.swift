import Cocoa
@testable import Utils
@testable import Element

class ScrollVList:VList{
    /**
     *
     */
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("ScrollVList.scrollWheel")
        (self as! Scrollable2).scroll(event)
        //super.scrollWheel(with: event)
    }
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("onScrollWheelChange")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("setProgress")
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
        
    }
}
