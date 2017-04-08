import Cocoa
@testable import Element
@testable import Utils

protocol SlidableScrollable3:Slidable3, Scrollable3 {}
extension SlidableScrollable3 {
    /**
     * 
     */
    func progress(_ dir:Dir)->CGFloat{
        return SliderListUtils.progress(event.delta[dir], interval(dir), slider(dir).progress)
    }
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("🏂📜 SlidableScrollable2.onScrollWheelChange: \(event)")
        let progressX:CGFloat = SliderListUtils.progress(event.delta[.hor], interval(.hor), slider(.hor).progress)
        slider(.hor).setProgressValue(progressX)
        let progressY:CGFloat = SliderListUtils.progress(event.delta[.ver], interval(.ver), slider(.ver).progress)
        slider(.ver).setProgressValue(progressY)
        setProgress(CGPoint(progressX,progressY))
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {//enables momentum
        onScrollWheelChange(event)
    }
    func onScrollWheelEnter() {//IMPORTANT: methods that are called from deep can only override upstream
        showSlider()
    }
    func onScrollWheelExit() {//IMPORTANT: methods that are called from deep can only override upstream
        hideSlider()
    }
}


