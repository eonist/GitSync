import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:ElasticScrollable, Slidable {
    
}
extension ElasticSlidableScrollable3{
    func scrollWheelExitedAndIsStationary() {
        Swift.print("👻🏂📜 ElasticSlidableScrollable2.scrollWheelExitedAndIsStationary()")
        hideSlider()
    }
}
