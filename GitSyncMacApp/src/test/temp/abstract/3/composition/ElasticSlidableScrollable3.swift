import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:ElasticScrollable3,Slidable3{}
extension ElasticSlidableScrollable3{
    /* func onScrollWheelChange(_ event: NSEvent) {
     (self as ElasticScrollable3).onScrollWheelChange(event)//forward the call
     if(event.phase == NSEventPhase.changed){
     
     }
     }*/
    override func onScrollWheelChange(_ event: NSEvent) {
        if(event.phase == NSEventPhase.changed){
            if(moverGroup!.isDirectlyManipulating){
                (self as Elastic3).setProgress(moverGroup!.result)
            }
        }
    }
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat, _ dir:Dir) {
        (self as Elastic3).setProgress(value,dir)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        (self as Slidable3).setProgress(sliderProgress,dir)
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func scrollWheelExitedAndIsStationary() {
        hideSlider()
    }
}
