import Cocoa
@testable import Element
@testable import Utils
/**
 * Testing x & y elastic scrolling
 */
class ElasticScrollView3:ContainerView3,ElasticScrollable3{
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    //lazy var iterimScrollGroup:IterimScrollGroup? = IterimScrollGroup()
}
