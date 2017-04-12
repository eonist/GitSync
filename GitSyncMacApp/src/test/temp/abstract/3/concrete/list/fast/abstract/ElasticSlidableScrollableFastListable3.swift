import Cocoa
@testable import Utils
@testable import Element


//continue here: 
    //you need to convert delta to

protocol ElasticSlidableScrollableFastListable3:Slidable3,ElasticScrollableFastListable3 {}
extension ElasticSlidableScrollableFastListable3{
    func setProgressValue(_ value: CGFloat, _ dir: Dir) {
        Swift.print("ElasticSlidableScrollableFastListable3.setProgress(val,dir)")
        setProgressVal(value, dir)//forward
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])//doing some double calculations here
        slider(dir).setProgressValue(sliderProgress)//temp fix
     }
    func scroll(_ event: NSEvent) {
        Swift.print("ElasticSlidableScrollableFastListable3.scroll")
        (self as Scrollable3).scroll(event)//forward the event
        if(event.phase == NSEventPhase.changed){
            let sliderProgress:CGPoint = ElasticUtils.progress(moverGroup!.result,contentSize,maskSize)
            (self as Slidable3).setProgress(sliderProgress)

        }
    }
}
