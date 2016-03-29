import Cocoa

//this is the current window for the Stash app

class TranslucencyWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    let w:CGFloat = 800
    let h:CGFloat = 600
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    var visualEffectView:TranslucencyView?//we set the to the background 
    /**
     *
     */
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: NSRect(0,0,w,h), styleMask: NSBorderlessWindowMask|NSResizableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.contentView!.wantsLayer = true;/*this can and is set in the view*/
        self.backgroundColor = NSColor.clearColor()/*Sets the window background color*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.movableByWindowBackground = false/*This enables you do drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        self.contentView = FlippedView(frame: NSRect(0,0,w,h))
        visualEffectView = TranslucencyView(frame: NSRect(0,0,w,h))
        
        
        self.contentView?.addSubview(visualEffectView!)
        let mainView = MainView(frame.width,frame.height)/*Sets the mainview of the window*/
        //let stashView = StashView(frame.width,frame.height)/*Sets the mainview of the window*/
        self.contentView?.addSubview(mainView)
    }
    func windowDidResize(notification: NSNotification) {
        //Swift.print("CustomWin.windowDidResize " + "\(self.frame.size)")
        visualEffectView!.setFrameSize(self.frame.size)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
