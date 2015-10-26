import Cocoa

class Button: NSButton {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        self.layer!.backgroundColor = CGColorCreateGenericRGB(1, 1, 0, 1)
        self.layer?.borderColor = CGColorCreateGenericRGB(1, 0, 1, 1)
        self.layer?.borderWidth = 5
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var wantsUpdateLayer:Bool{//enables the call of updateLayer
        return true
    }
}