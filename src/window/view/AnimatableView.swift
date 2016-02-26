import Cocoa
/**
 * NOTE: This view class serves as a basis for frame animation.
 * NOTE: override the onFrame method to do frame animations
 * NOTE: Start and stop with CVDisplayLinkStart(displayLink) and CVDisplayLinkStop(displayLink)
 */
class AnimatableView:CustomView,IAnimatable {
    var displayLink: CVDisplayLink!/*This is the instance that enables frame animation*/
    override func resolveSkin() {
        super.resolveSkin()
        displayLink = setUpDisplayLink()
        //Swift.print("displayLink: " + "\(displayLink)")
    }
    /**
     * Fires on every screen refresh at 60 FPS, or device speed
     */
    func onFrame(){
        //Swift.print("\(self.dynamicType)" + "onFrame()")
        CATransaction.flush()/*if you dont flush your animation wont animate and you get this message: CoreAnimation: warning, deleted thread with uncommitted CATransaction; set CA_DEBUG_TRANSACTIONS=1 in environment to log backtraces.*/
    }
    /**
     * Note: It seems that you cant move this method into a static class method. Either internally in the same file or externally in another file
     */
    func setUpDisplayLink() -> CVDisplayLink {
        var displayLink: CVDisplayLink?
        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        Swift.print("status: " + "\(status)")
        /* Set up DisplayLink. This method fires 60fps*/
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            //Swift.print("displayLink is setup")
            unsafeBitCast(displayLinkContext, AnimatableView.self).onFrame()//drawRect(unsafeBitCast(displayLinkContext, NSOpenGLView.self).frame)
            return kCVReturnSuccess
        }
        let outputStatus = CVDisplayLinkSetOutputCallback(displayLink!, displayLinkOutputCallback, UnsafeMutablePointer<Void>(unsafeAddressOf(self)))
        Swift.print("outputStatus: " + "\(outputStatus)")
        let displayID = CGMainDisplayID()
        let displayIDStatus = CVDisplayLinkSetCurrentCGDisplay(displayLink!, displayID)
        Swift.print("displayIDStatus: " + "\(displayIDStatus)")
        return displayLink!
    }
}
