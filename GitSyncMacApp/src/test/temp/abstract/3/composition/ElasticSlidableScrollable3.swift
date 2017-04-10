import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:Slidable3,ElasticScrollable3{}
extension ElasticSlidableScrollable3{
    func setProgress(_ point: CGPoint) {
        Swift.print("ElasticSlidableScrollable3.setProgress(p)")
        fatalError("debug")
    }
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat, _ dir:Dir) {
        Swift.print("ElasticSlidableScrollable3.setProgress()")
        //(self as Elastic3).setProgress(value,dir)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        //Swift.print("sliderProgress: " + "\(sliderProgress)")
        
        slider(dir).setProgressValue(sliderProgress)//temp fix
        (self as Progressable3).setProgress(sliderProgress,dir)//temp fix
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//override to cancel out the event
    func scrollWheelExitedAndIsStationary() {
        Swift.print("ElasticSlidableScrollable3.scrollWheelExitedAndIsStationary()")
        hideSlider()
    }
}


