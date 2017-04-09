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
}
