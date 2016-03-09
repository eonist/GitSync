import Cocoa

//The view should extend Element
//white background
//svg icon test
//setup views leftSideBarView and MainContentView


class TranslucencyWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    var visualEffectView:TranslucencyView?
    /**
     *
     */
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: NSRect(0,0,300,300), styleMask: NSBorderlessWindowMask|NSResizableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.contentView!.wantsLayer = true;/*this can and is set in the view*/
        self.backgroundColor = NSColor.clearColor()/*Sets the window background color*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.movableByWindowBackground = true/*This enables you do drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        self.contentView = FlippedView(frame: NSRect(0,0,300,300))
        let visualEffectView = TranslucencyView(frame: NSRect(0,0,300,300))
        self.contentView?.addSubview(visualEffectView)
    }
    func windowDidResize(notification: NSNotification) {
        Swift.print("CustomWin.windowDidResize " + "\(self.frame.size)")
        visualEffectView?.setFrameSize(self.frame.size)
        visualEffectView?.setBoundsSize(self.frame.size)
        visualEffectView?.maskImage?.size = self.frame.size
        visualEffectView?.maskImage?
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
