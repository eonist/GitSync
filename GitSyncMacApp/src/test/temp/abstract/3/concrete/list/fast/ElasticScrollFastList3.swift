import Foundation
@testable import Utils
@testable import Element

class ElasticScrollFastList3:FastList3,ElasticScrollableFastListable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    var rbContainer:Container?/*needed for the overshot animation*/
    override func resolveSkin() {
        super.resolveSkin()
        /*rbContainer*/
        rbContainer = addSubView(Container(w,h,self,"rb"))
        rbContainer!.addSubview(contentContainer!)//add lable Container inside rbContainer
        contentContainer!.parent = rbContainer!
    }
}
