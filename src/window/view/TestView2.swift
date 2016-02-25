import Cocoa

class TestView2:CustomView{
    var rect:RectGraphic!
    override func resolveSkin() {
        super.resolveSkin()
        //Swift.print("CustomView.resolveSkin()")
        frameAnimTest()

    }
    private var displayLink: CVDisplayLink!
    //var displayID:CGDirectDisplayID?
    //var error:CVReturn? = kCVReturnSuccess
    func frameAnimTest(){
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
        var toggle:Bool = true
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                Swift.print("button works")
                toggle ? CVDisplayLinkStart(displayLink) : CVDisplayLinkStop(displayLink);//To start capturing events from the display link, you'd use
                toggle = !toggle
            }
        }
        btn.event = onEvent

        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*Rect*/
        rect = RectGraphic(0,0,150,150,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        rect.graphic.frame.y = 60/**/
        
        
        displayLink = setUpDisplayLink()
        
        Swift.print("displayLink: " + "\(displayLink)")
        
        
        //animate a square 100 pixel to the right then stop the frame anim
        /*displayID = CGMainDisplayID();
        
        let pointer = UnsafeMutablePointer<CVDisplayLink?>(unsafeAddressOf(self))
        
        Swift.print("pointer: " + "\(pointer)")
        
        error = CVDisplayLinkCreateWithCGDisplay(displayID!, pointer)*/
        
        
        /*if let error = error {
        Swift.print("An error occurred \(error)")
        } else {
        Swift.print("no error")
        }*/

    }
    /**
     *
     */
    func drawSomething(){
        //Swift.print("drawSomething")
        
        
        
        
        //  Grab a context from our view and make it current for drawing into
        //  CVDisplayLink uses a separate thread, lock focus or our context for thread safety
        
        
        //Swift.print("self.openGLContext: " + "\(self.openGLContext)")
        
        /**/
        /*let context:NSOpenGLContext = NSOpenGLContext.currentContext()!
        
        Swift.print("context: " + "\(context)")
        
        context.makeCurrentContext()
        CGLLockContext(context.CGLContextObj)*/
        
        
        //rect.graphic.fillShape.graphics.context = context.
        if(rect.graphic.frame.x < 100){
            rect.graphic.frame.x += 1
        }else{
            CVDisplayLinkStop(displayLink);
        }

        CATransaction.flush()
    }
    func setUpDisplayLink() -> CVDisplayLink {
        var displayLink: CVDisplayLink?
        
        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        Swift.print("status: " + "\(status)")
        
        /* Set up DisplayLink. */
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            //Swift.print("works")
            unsafeBitCast(displayLinkContext, TestView2.self).drawSomething()//drawRect(unsafeBitCast(displayLinkContext, NSOpenGLView.self).frame)
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
