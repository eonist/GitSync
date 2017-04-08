import Cocoa
@testable import Element
@testable import Utils
/**
 * Testing x & y elastic scrolling
 */
class ElasticView:ContainerView3,ElasticScrollable3{//
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    var moverGroup:MoverGroup?
    var iterimScrollGroup:IterimScrollGroup?
    
    override func resolveSkin() {
        super.resolveSkin()
        iterimScrollGroup = IterimScrollGroup()
        moverGroup = MoverGroup(setProgress,maskSize,contentSize)
    }
    //move this into a clause extension
    }

/*extension ElasticView{
 override func scrollWheel(with event: NSEvent) {
 Swift.print("scrolling")
 //Swift.print("scrollWheel event.scrollingDeltaX: \(event.scrollingDeltaX) event.scrollingDeltaY: \(event.scrollingDeltaY)")
 scroll(event)
 super.scrollWheel(with:event)
 }
 }*/

extension ContainerView3{//use some where magic? see your notes on this
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("scroll")
        if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }
        super.scrollWheel(with: event)
    }
}
