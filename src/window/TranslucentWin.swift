import Cocoa

class TranslucentWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    /**
     *
     */
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
         //NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask|NSFullSizeContentViewWindowMask
        super.init(contentRect: Win.sizeRect, styleMask: NSBorderlessWindowMask|NSResizableWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        self.contentView!.wantsLayer = true;/*this can and is set in the view*/
        self.backgroundColor = NSColor.greenColor().alpha(0.2)
        self.opaque = false
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMainWindow()//makes it the apps main menu?
        self.hasShadow = true
        //self.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        self.titlebarAppearsTransparent = true
        self.center()
        self.movableByWindowBackground = true
        
        //self.contentView = view
        //self.title = ""/*Sets the title of the window*/
        self.title = ""//GitSync
        
        self.delegate = self
        
        let visualEffectView = NSVisualEffectView(frame: NSMakeRect(0, 0, Win.sizeRect.width, Win.sizeRect.height))
        visualEffectView.material = NSVisualEffectMaterial.UltraDark//AppearanceBased,Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        visualEffectView.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        visualEffectView.state = NSVisualEffectState.Active
        
        self.contentView?.addSubview(visualEffectView)
        //self.contentView = visualEffectView
       
        /* self.contentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[visualEffectView]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["visualEffectView":visualEffectView]))
        self.contentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[visualEffectView]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["visualEffectView":visualEffectView]))
        */
        //visualEffectView.wantsLayer = true;//this should be set in the iew not here
        //visualEffectView.allowsVibrancy.interiorBackgroundStyle // only radable
        //visualEffectView.allowsVibrancy = true
        //visualEffectView.blendingMode = NSVisualEffectBlendingModeWithinWindow,
   
    }
    
    /*
    visualEffectView.maskImage = maskImage(cornerRadius: 10.0)/*this line applies the mask to the view*/
    func maskImage(cornerRadius cornerRadius: CGFloat) -> NSImage {
    let edgeLength = 2.0 * cornerRadius + 1.0
    let maskImage = NSImage(size: NSSize(width: edgeLength, height: edgeLength), flipped: false) { rect in
    let bezierPath = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
    NSColor.blackColor().set()
    bezierPath.fill()
    return true
    }
    maskImage.capInsets = NSEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius)
    maskImage.resizingMode = .Stretch
    return maskImage
    }
    */
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
/*class ViewAllowsVibrancy: NSView {
override var allowsVibrancy: Bool {
return true
}
}*/