import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:ElasticScrollable3,Slidable3{}
extension ElasticSlidableScrollable3{
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat) {
        Swift.print("👻🏂📜 ElasticSlidableScrollable.setProgress(\(value)) 💥")
        (self as Elastic).setProgress(value)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        slider!.setProgressValue(sliderProgress)//<- scalar value 0-1
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func scrollWheelExitedAndIsStationary() {
        hideSlider()
    }
}
