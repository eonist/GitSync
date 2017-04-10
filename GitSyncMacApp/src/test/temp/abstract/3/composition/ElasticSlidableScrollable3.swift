import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:Slidable3,ElasticScrollable3{}
extension ElasticSlidableScrollable3{
    /*func setProgress(_ point: CGPoint) {
     Swift.print("ElasticSlidableScrollable3.setProgress(p)")
     
     }*/
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
    func scroll(_ event: NSEvent) {
        //Swift.print("👻🏂📜 ElasticSlidableScrollable3.scroll()")
        (self as Scrollable3).scroll(event)
        if(event.phase == NSEventPhase.changed){
            if(moverGroup!.isDirectlyManipulating){
                //also manipulates slider, but only on directTransmission, as mover calls setProgress from shallow in indirectTransmission
                //setProgress(moverGroup!.result.y,.ver)//👈NEW, this migth need to be inSide scrollWheel call, as it needs to be shallow to reach inside setProgress in ElasticFastList.setProgress, but maybe not, To be continued
                //let sliderProgress:CGFloat = ElasticUtils.progress(moverGroup!.result.y,contentSize[.ver],maskSize[.ver])
                let sliderProgress:CGPoint = ElasticUtils.progress(moverGroup!.result,contentSize,maskSize)
                //Swift.print("sliderProgress: " + "\(sliderProgress)")
                (self as Slidable3).setProgress(sliderProgress)
                //slider(.ver).setProgressValue(sliderProgress)//temp fix
            }
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider(.ver)
            showSlider(.hor)
        }
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//override to cancel out the event
    func scrollWheelExitedAndIsStationary() {
        //Swift.print("⚠️️⚠️️⚠️️ ElasticSlidableScrollable3.scrollWheelExitedAndIsStationary()")
        hideSlider(.ver)
        hideSlider(.hor)
    }
}


