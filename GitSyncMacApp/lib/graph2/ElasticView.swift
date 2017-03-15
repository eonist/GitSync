import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: Pinch to zoom
 * TODO: slidable in x-axis
 * TODO: bounce back x-axis
 * TODO: bounce back on zoom min and max
 */
class ElasticView:Element{
    var maskFrame:CGRect = CGRect()
    var contentFrame:CGRect = CGRect()
    var contentContainer:Element?
    /**/
    var mover:RubberBand?
    var iterimScroll:InterimScroll = InterimScroll()
    
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        contentContainer = addSubView(Container(width,height,self,"content"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
        
        maskFrame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentFrame = CGRect(0,0,width,600)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress/*👈important*/,maskFrame,contentFrame)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    
    }
    /**
     *
     */
    func setProgress(_ value:CGFloat){
        Swift.print("value: " + "\(value)")
    }
    
    override func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        super.scrollWheel(with: event)
    }
    
}
