import Cocoa

class Button: NSButton {
    var fillColor:NSColor = NSColor.clearColor()
    var strokeColor:NSColor = NSColor.clearColor()
    init(_ width: Int = 100, _ height: Int = 100, _ fillColor:NSColor = NSColor.clearColor(), _ strokeColor:NSColor = NSColor.clearColor()) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true
    }
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        let fillStyle = FillStyle(fillColor)
        if(fillStyle.color != NSColor.clearColor()){
            let fillColor = fillStyle.cgColor//NSColorParser.cgColor(self.fillColor)
            layer?.backgroundColor = fillColor//CGColorCreateGenericRGB(1, 0, 1, 1)
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