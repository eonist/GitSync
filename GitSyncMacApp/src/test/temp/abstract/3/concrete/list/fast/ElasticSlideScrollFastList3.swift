import Foundation
@testable import Utils
@testable import Element

class ElasticSlideScrollFastList3:SlideFastList3,ElasticSlidableScrollableFastListable3 {
    lazy var moverGroup:MoverGroup? = self.moverGrp
    lazy var rbContainer:Container? = self.rubberBandContainer/*needed for the overshot animation*/
    override func onEvent(_ event:Event) {
        if(event.type == AnimEvent.stopped){
            let dir:Dir = event.origin === moverGroup!.yMover ? .ver : .hor
            hideSlider(dir)/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
