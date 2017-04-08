import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:ElasticScrollable3,Slidable3{}
extension ElasticSlidableScrollable3{
    func onScrollWheelChange(_ event: NSEvent) {
        (self as ElasticScrollable3).onScrollWheelChange(event)
        if(event.phase == NSEventPhase.changed){
            if(moverGroup!.isDirectlyManipulating){
                //also manipulates slider, but only on directTransmission, as mover calls setProgress from shallow in indirectTransmission
                setProgress(mover!.result)//👈NEW, this migth need to be inSide scrollWheel call, as it needs to be shallow to reach inside setProgress in ElasticFastList.setProgress, but maybe not, To be continued
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
