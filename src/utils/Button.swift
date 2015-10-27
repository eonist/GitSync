import Cocoa

class Button: NSButton {
    var fillColor:NSColor = NSColor.clearColor()
    var strokeColor:NSColor = NSColor.clearColor()
    var style:IStyle = Style.clear
    init(_ width: Int = 100, _ height: Int = 100, style:IStyle) {
        self.style = style
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true
    }
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        if(style.fill.color != NSColor.clearColor()){
            layer?.backgroundColor = style.fill.cgColor//CGColorCreateGenericRGB(1, 0, 1, 1)
        }
        if(strokeColor != NSColor.clearColor()){
            let strokeColor = NSColorParser.cgColor(self.strokeColor)
            layer?.borderColor = strokeColor//CGColorCreateGenericRGB(0, 1, 0, 1)
            layer?.borderWidth = 5
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var wantsUpdateLayer:Bool{//enables the call of updateLayer
        return true
    }
}