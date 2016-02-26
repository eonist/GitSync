import Cocoa

class DisplayLinkUtils {
    class func setUpDisplayLink() -> CVDisplayLink {
        var displayLink: CVDisplayLink?
        
        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        Swift.print("status: " + "\(status)")
        
        /* Set up DisplayLink. */
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            //Swift.print("displayLink is setup")
            unsafeBitCast(displayLinkContext, IAnimateable.self).onFrame()//drawRect(unsafeBitCast(displayLinkContext, NSOpenGLView.self).frame)
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
