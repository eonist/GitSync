import Cocoa
protocol IElement{
    func resolveSkin()
}
class Element: FlippedView,IElement {
    var style:IStyle
    init(_ width: Int = 100, _ height: Int = 40, _ style:IStyle = Style.clear){
        self.style = style
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true//need for the updateLayer method to be called internally
    }
    
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        resolveSkin()
    }
    /*
    * Required by NSView
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Element{
    func resolveSkin() {
        if(style.fill.color != NSColor.clearColor()){
            layer?.backgroundColor = style.fill.cgColor
        }
        if(style.stroke.color != NSColor.clearColor()){
            layer?.borderColor = style.stroke.cgColor
            layer?.borderWidth = style.stroke.width
        }
    }
}