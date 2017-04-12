import Foundation
@testable import Utils
@testable import Element

class ElasticScrollFastList3:FastList3,ElasticScrollableFastListable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgressVal,self.maskSize,self.contentSize)
    var rbContainer:Container?/*needed for the overshot animation*/
    override func resolveSkin() {
        super.resolveSkin()
        /*rbContainer*/
        
    }
}
extension Elastic3 where Self:FastListable3{
    var rbContainer:Container
}
