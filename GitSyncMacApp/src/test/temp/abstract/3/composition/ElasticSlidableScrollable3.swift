import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:Slidable3,ElasticScrollable3{}
extension ElasticSlidableScrollable3{
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat, _ dir:Dir) {
        Swift.print("ElasticSlidableScrollable3.setProgress()")
        /**/(self as Elastic3).setProgress(value,dir)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        //Swift.print("sliderProgress: " + "\(sliderProgress)")
        
        slider(dir).setProgressValue(sliderProgress)//temp fix
        (self as Progressable3).setProgress(sliderProgress,dir)//temp fix
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {}
    func scrollWheelExitedAndIsStationary() {
        hideSlider()
    }
}
extension SlideView3{
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        /*else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
         //hideSlider()
         }*/
    }
}
