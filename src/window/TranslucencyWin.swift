import Cocoa
//chromless
//dark
//resizable
//translucent


class TranslucencyWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    override var canBecomeMainWindow:Bool{return true}
    override var canBecomeKeyWindow:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
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
        
        let visualEffectView = NSVisualEffectView(frame: NSRect(0,0,300,300))
        visualEffectView.material = NSVisualEffectMaterial.UltraDark//AppearanceBased,Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        visualEffectView.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        visualEffectView.state = NSVisualEffectState.Active
        self.contentView = (visualEffectView)
        visualEffectView.maskImage = maskImage(cornerRadius: 8.0)/*this line applies the mask to the view*/
        
        
        //continue here: pack the visualEffectView into its own class, then go on from there
    }
    
    
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
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by the NSWindow*/
}
