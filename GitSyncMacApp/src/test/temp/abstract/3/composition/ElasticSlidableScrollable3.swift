import Cocoa
@testable import Element
@testable import Utils

//continue here: 🏀
    //onEnter is overshadowing the default method, use scroll to adhock the showSlider method instead. 👈

protocol ElasticSlidableScrollable3:Slidable3,ElasticScrollable3{}
extension ElasticSlidableScrollable3{
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat, _ dir:Dir) {
        //Swift.print("👻🏂📜ElasticSlidableScrollable3.setProgress() dir: \(dir) value: \(value)")
        //(self as Elastic3).setProgress(value,dir)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        //Swift.print("sliderProgress: " + "\(sliderProgress)")
        slider(dir).setProgressValue(sliderProgress)//temp fix
        //(self as Elastic3).setProgress(value,dir)//temp fix
        contentContainer!.point[dir] = value
    }
    func scroll(_ event:NSEvent) {
        //Swift.print("👻🏂📜 ElasticSlidableScrollable3.scroll()")
        (self as Scrollable3).scroll(event)
        if(event.phase == NSEventPhase.changed){
            let sliderProgress:CGPoint = ElasticUtils.progress(moverGroup!.result,contentSize,maskSize)
            (self as Slidable3).setProgress(sliderProgress)
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        if(event.momentumPhase == NSEventPhase.began){//simulates: onScrollWheelMomentumBegan()
            Swift.print("🍊 ElasticSlidableScrollable3.onScrollWheelMomentumBegan")
            showSlider()//cancels out the hide call when onScrollWheelExit is called when you release after pan gesture
        }
    }
    func onScrollWheelEnter() {
        Swift.print("ElasticSlidableScrollable3.onScrollWheelEnter")
        showSlider()
    }
    func onScrollWheelCancelled() {
        Swift.print("ElasticSlidableScrollable3.onScrollWheelCancelled")
        hideSlider()
    }
    func onScrollWheelExit() {
        Swift.print("ElasticSlidableScrollable3.onScrollWheelExit")
        hideSlider()
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//override to cancel out the event
}

/*
 func scrollWheelExitedAndIsStationary() {
 Swift.print("⚠️️⚠️️⚠️️ ElasticSlidableScrollable3.scrollWheelExitedAndIsStationary()")
 fatalError("debug")
 hideSlider()
 }
 */

/*func setProgress(_ point: CGPoint) {
 Swift.print("ElasticSlidableScrollable3.setProgress(p)")
 
 }*/
