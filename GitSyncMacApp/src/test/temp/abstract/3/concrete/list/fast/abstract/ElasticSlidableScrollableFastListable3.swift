import Cocoa
@testable import Utils
@testable import Element

protocol ElasticSlidableScrollableFastListable3:Slidable3,ElasticScrollableFastListable3 {}
extension ElasticSlidableScrollableFastListable3{
    func setProgressValue(_ value: CGFloat, _ dir: Dir) {
        Swift.print("ElasticSlidableScrollableFastListable3.setProgress")
        setProgressVal(value, dir)//forward
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])//doing some double calculations here
        slider(dir).setProgressValue(sliderProgress)//temp fix
     }
    func scroll(_ event: NSEvent) {
        Swift.print("ElasticSlidableScrollableFastListable3.scroll")
        (self as Scrollable3).scroll(event)//forward the event
        if(event.phase == NSEventPhase.changed){
            setProgressValue(event.deltaY,.ver)//not great need to set point not number
        }
    }
}
