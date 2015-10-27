import Cocoa

class Button: NSButton {
    var style:IStyle
    init(_ width: Int = 100, _ height: Int = 100, _ style:IStyle = Style.clear) {
        self.style = style
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true//need for the updateLayer method to be called internally
    }
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        if(style.fill.color != NSColor.clearColor()){
            layer?.backgroundColor = style.fill.cgColor
        }
        if(style.stroke.color != NSColor.clearColor()){
            layer?.borderColor = style.stroke.cgColor
            layer?.borderWidth = style.stroke.width
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var wantsUpdateLayer:Bool{//enables the call of updateLayer
        return true
    }
}