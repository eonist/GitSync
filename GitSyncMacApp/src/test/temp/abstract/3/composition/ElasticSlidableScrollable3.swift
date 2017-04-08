import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:ElasticScrollable3,Slidable3{}
extension ElasticSlidableScrollable3{
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
