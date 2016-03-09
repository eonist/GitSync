import Cocoa
/**
 * NOTE: This view class serves as a basis for frame animation.
 * NOTE: override the onFrame method to do frame animations
 * NOTE: Start and stop with CVDisplayLinkStart(displayLink) and CVDisplayLinkStop(displayLink) and CVDisplayLinkIsRunning(displayLink) to assert if the displayLink is running
 */


//TODO: move the animation stuff into a new class named AnimWin that extends window, customwin will extend animwin for now untill you make a singleton or global val


//TODO:IMplement the Animatable as a singlton and move it to the animation folder

class CustomWin:Window{
    
    
    override init(_ width:CGFloat = 600,_ height:CGFloat = 400){
        super.init(width,height)
    }
    override func resolveSkin() {
        self.contentView = TestView7(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    override func windowDidResize(notification: NSNotification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}