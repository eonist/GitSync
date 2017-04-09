import Cocoa
@testable import Utils

class ElasticSlideScrollView3:SlideView3,ElasticSlidableScrollable3 {
    var moverGroup:MoverGroup?
    var iterimScrollGroup:IterimScrollGroup?
    
    override func resolveSkin() {
        super.resolveSkin()
        iterimScrollGroup = IterimScrollGroup()
        moverGroup = MoverGroup(setProgress,maskSize,contentSize)
    }
    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, moverGroup!)){
            Swift.print("anim stopped")
            hideSlider()/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
