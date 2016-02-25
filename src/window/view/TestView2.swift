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
        
         
         //  some OpenGL setup
         //  NSOpenGLPixelFormatAttribute is a typealias for UInt32 in Swift, cast each attribute
         //  Set the view's PixelFormat and Context to the custom pixelFormat and context
        
        
        displayLink = setUpDisplayLink()
        
        Swift.print("displayLink: " + "\(displayLink)")
        
        
        //self.pixelFormat = pixelFormat

        
        
        
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
        
        rect.graphic.display()
        CATransaction.flush()
        
        //continue here: gather more information, start a project from scrath to not clutter up the framework anymore.
        //also maybe just try the NSTimer, and then revisit CVDisplayLink later
        
        /*
        
        //  Clear the context, set up the OpenGL shader program(s), call drawing commands
        //  OpenGL targets and such are UInt32's, cast them before sending in the OpenGL function
        
        glClear(UInt32(GL_COLOR_BUFFER_BIT))
        
        //  We're using a double buffer, call CGLFlushDrawable() to swap the buffer
        //  We're done drawing, unlock the context before moving on
        
        CGLFlushDrawable(context.CGLContextObj)
        CGLUnlockContext(context.CGLContextObj)*/
    }
    func setUpDisplayLink() -> CVDisplayLink {
        var displayLink: CVDisplayLink?
        
        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        Swift.print("status: " + "\(status)")
        
        /* Set up DisplayLink. */
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            Swift.print("display link is setup")
            
            
            let attrs: [NSOpenGLPixelFormatAttribute] = [
                UInt32(NSOpenGLPFAAccelerated),
                UInt32(NSOpenGLPFAColorSize), UInt32(32),
                UInt32(NSOpenGLPFADoubleBuffer),
                UInt32(NSOpenGLPFAOpenGLProfile),
                UInt32( NSOpenGLProfileVersion3_2Core),
                UInt32(0)
            ]
            
            let pixelFormat:NSOpenGLPixelFormat? = NSOpenGLPixelFormat(attributes: attrs)
            
            let cglPixelFormat = pixelFormat?.CGLPixelFormatObj
            let openGLContext:NSOpenGLContext? = NSOpenGLContext.currentContext()
            Swift.print("openGLContext: " + "\(openGLContext)")
            let cglContext = openGLContext!.CGLContextObj
            CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat!)
            CVDisplayLinkStart(displayLink)
            
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
