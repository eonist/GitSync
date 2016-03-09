import Cocoa

class TranslucencyView:NSVisualEffectView{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.material = NSVisualEffectMaterial.UltraDark//AppearanceBased,Dark,MediumLight,PopOver,UltraDark,AppearanceBased,Titlebar,Menu
        self.blendingMode = NSVisualEffectBlendingMode.BehindWindow
        self.state = NSVisualEffectState.Active
        //self.maskImage = maskImage(cornerRadius: 8.0)/*this line applies the mask to the view*/
    }
    /**
     *
     */
    func setSize(frame:NSRect){
        self.frame = frame
        self.maskImage = maskImage(cornerRadius: 8.0)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension TranslucencyView{
    func maskImage(cornerRadius cornerRadius: CGFloat) -> NSImage {
        let edgeLength = 2.0 * cornerRadius + 1.0
        Swift.print("edgeLength: " + "\(edgeLength)")
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
}
