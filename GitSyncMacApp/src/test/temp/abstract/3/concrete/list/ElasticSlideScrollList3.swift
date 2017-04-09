import Foundation
@testable import Utils
@testable import Element

class ElasticSlideScrollList3:SlideList3,ElasticScrollable3 {
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
