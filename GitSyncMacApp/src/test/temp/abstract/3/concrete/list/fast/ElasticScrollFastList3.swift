import Foundation

class ElasticScrollFastList3:FastList3,ElasticScrollable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
}
