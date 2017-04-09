import Cocoa
@testable import Utils

class ElasticSlideScrollView3:SlideView3,ElasticSlidableScrollable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    lazy var iterimScrollGroup:IterimScrollGroup? = IterimScrollGroup()

    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, moverGroup!)){
            Swift.print("anim stopped")
            hideSlider()/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
