import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle
    init(_ width: Int = 100, _ height: Int = 40, _ style:IStyle = Style.clear){
        self.style = style
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true//need for the updateLayer method to be called internally
    }
    /*
    * Called on init if wantsUpdateLayer is true
    */
    override func updateLayer() {
        resolveSkin()//extension method that draws the graphics
    }
    /*
    * Required by NSView
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IElement{
    /*
    * Draws the graphics
    * NOTE: this method is embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
    */
    func resolveSkin() {
        //fill
        let fillColor:Int = style.getStyleProperty("fillColor")!.value as! Int
        //Swift.print("fillColor: " + "\(fillColor)")
        
        let fillAlpha:Double = style.getStyleProperty("fillAlpha")!.value as! Double
        
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))
        let cgFillColor = NSColorParser.cgColor(nsFillColor)
        
        if(nsFillColor != NSColor.clearColor()){/*clearColor: 0.0 white, 0.0 alpha */
            //Swift.print("fill")
            layer?.backgroundColor = cgFillColor
            
        }
        
    }
}