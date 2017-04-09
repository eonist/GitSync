import Cocoa
@testable import Utils

class ElasticSlideScrollView3:SlideView3,ElasticSlidableScrollable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    lazy var iterimScrollGroup:IterimScrollGroup? = IterimScrollGroup()
    
    
    override func resolveSkin() {
        super.resolveSkin()
        moverGroup!.xMover.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        moverGroup!.yMover.event = onEvent
    }
    override func onEvent(_ event:Event) {
        Swift.print("ElasticSlideScrollView3.onEvent \(event.type)")
        if(event === (AnimEvent.stopped, moverGroup!.yMover)){//only supports yMover atm
            Swift.print("anim stopped")
            hideSlider()/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
