import Cocoa
@testable import Element
@testable import Utils
/**
 * Testing x & y elastic scrolling
 */
class ElasticView:ContainerView2{//
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    var moverGroup:MoverGroup?
    var iterimScrollGroup:IterimScrollGroup?
    
    override func resolveSkin() {
        super.resolveSkin()
        iterimScrollGroup = IterimScrollGroup()
        moverGroup = MoverGroup(setProgress,maskSize,contentSize)
    }
    override func scrollWheel(with event: NSEvent) {
        //Swift.print("scrollWheel event.scrollingDeltaX: \(event.scrollingDeltaX) event.scrollingDeltaY: \(event.scrollingDeltaY)")
        (self as! Scrollable3).scroll(event)
        super.scrollWheel(with:event)
    }
}
/*Pan related*/
extension ElasticView{
    func setProgress(_ value:CGFloat,_ dir:Dir){
        contentContainer!.point[dir] = value
    }
    func setProgress(_ point:CGPoint){
        contentContainer!.point = point
    }
    
}
