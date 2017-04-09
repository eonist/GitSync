import Cocoa
@testable import Element
@testable import Utils
/**
 * Testing x & y elastic scrolling
 */
class ElasticView3:ContainerView3,ElasticScrollable3{//
    var moverGroup:MoverGroup?
    var iterimScrollGroup:IterimScrollGroup?
    
    override func resolveSkin() {
        super.resolveSkin()
        iterimScrollGroup = IterimScrollGroup()
        moverGroup = MoverGroup(setProgress,maskSize,contentSize)
    }
}
