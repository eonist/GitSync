import Cocoa

class TranslucentWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    /**
     *
     */
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: Win.sizeRect, styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask|NSFullSizeContentViewWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.contentView!.wantsLayer = true;/*this can and is set in the view*/
        //self.backgroundColor = NSColor.greenColor().alpha(0.2)
        //self.opaque = true
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        //self.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.titlebarAppearsTransparent = true
        self.center()
        
        //self.contentView = view
        //self.title = ""/*Sets the title of the window*/
        self.title = ""//GitSync
        
        self.delegate = self
        
        let visualEffectView = NSVisualEffectView(frame: NSMakeRect(0, 0, 0, 0))
        visualEffectView.material = NSVisualEffectMaterial.AppearanceBased//Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        visualEffectView.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        visualEffectView.state = NSVisualEffectState.Active
        self.contentView?.addSubview(visualEffectView)
        //visualEffectView.wantsLayer = true;//this should be set in the iew not here
        //visualEffectView.allowsVibrancy.interiorBackgroundStyle // only radable
        //visualEffectView.allowsVibrancy = true
        //visualEffectView.blendingMode = NSVisualEffectBlendingModeWithinWindow,

        
    }
    /*
     * Required by the NSWindow
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class ViewAllowsVibrancy: NSView {
    override var allowsVibrancy: Bool {
        return true
    }
}