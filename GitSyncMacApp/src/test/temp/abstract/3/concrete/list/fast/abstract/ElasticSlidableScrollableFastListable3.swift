import Cocoa
@testable import Utils
@testable import Element

protocol ElasticSlidableScrollableFastListable3:Slidable3,ElasticScrollableFastListable3 {}
extension ElasticSlidableScrollableFastListable3{
    func scroll(_ event: NSEvent) {
        (self as Scrollable3).scroll(event)//forward the event
    }
}
