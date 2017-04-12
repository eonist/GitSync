import Cocoa
@testable import Utils
@testable import Element

protocol ElasticSlidableScrollableFastListable3:Slidable3,ElasticScrollableFastListable3 {}
extension ElasticSlidableScrollableFastListable3{
    func setProgress(_ value: CGFloat, _ dir: Dir) {
        Swift.print("ElasticSlidableScrollableFastListable3.setProgress")
    }
}
/*
func scroll(_ event: NSEvent) {
    (self as Scrollable3).scroll(event)//forward the event
    if(event.phase == NSEventPhase.changed){
        
    }
}
*/
