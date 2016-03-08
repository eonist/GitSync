import Cocoa

class CustomWin:Window{
    var animators:Array<BaseAnimation> = []
    var drawCalls:Array<()->Void> = []
    lazy var displayLink: CVDisplayLink = self.setUpDisplayLink()/*This is the instance that enables frame animation, lazying this value will probably haunt me later, playing with fire*/
    override func resolveSkin() {
        self.contentView = TestView7(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    override func windowDidResize(notification: NSNotification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
    
    /**
     * Fires on every screen refresh at 60 FPS, or device speed
     */
    func onFrame(){
        //Swift.print("\(self.dynamicType)" + "onFrame()")
        for animator in animators{animator.onFrame()}
        while drawCalls.count > 0{
            if(drawCalls.count > 0){drawCalls.removeFirst()()}//the extra assert was needed strangly enough, or els bugs started to appear after some time with stress testing
        }
        CATransaction.flush()/*if you dont flush your animation wont animate and you get this message: CoreAnimation: warning, deleted thread with uncommitted CATransaction; set CA_DEBUG_TRANSACTIONS=1 in environment to log backtraces.*/
    }
    /**
     * Note: It seems that you can't move this method into a static class method. Either internally in the same file or externally in another file
     */
    func setUpDisplayLink() -> CVDisplayLink {
        Swift.print("setUpDisplayLink()")
        var displayLink: CVDisplayLink?
        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        //Swift.print("status: " + "\(status)")
        /* Set up DisplayLink. This method fires 60fps*/
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            //Swift.print("displayLink is setup")
            unsafeBitCast(displayLinkContext, CustomWin.self).onFrame()//drawRect(unsafeBitCast(displayLinkContext, NSOpenGLView.self).frame)
            return kCVReturnSuccess
        }
        let outputStatus = CVDisplayLinkSetOutputCallback(displayLink!, displayLinkOutputCallback, UnsafeMutablePointer<Void>(unsafeAddressOf(self)))
        outputStatus
        //Swift.print("outputStatus: " + "\(outputStatus)")
        let displayID = CGMainDisplayID()
        let displayIDStatus = CVDisplayLinkSetCurrentCGDisplay(displayLink!, displayID)
        displayIDStatus
        //Swift.print("displayIDStatus: " + "\(displayIDStatus)")
        return displayLink!
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}