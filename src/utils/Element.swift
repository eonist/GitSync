import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle = Style.clear
    init(_ width: Int = 100, _ height: Int = 40){
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
    mutating func resolveSkin() {
        
        
        //TODO: Figure out what css like "over color" is named as a Style.name, the use this namingconvention when you create your test styles
        //TODO: add this GraphicModifier.applyProperties to your code
        
        self.style = StyleManager.getStyle("element")!
        
        //fill
        let fillColor:String = style.getStyleProperty("fillColor")!.value as! String
        let fillAlpha:Double = style.getStyleProperty("fillAlpha")!.value as! Double
        //Swift.print("fillColor: " + "\(fillColor)")
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))
        let cgFillColor = NSColorParser.cgColor(nsFillColor)
        
        if(nsFillColor != NSColor.clearColor()){/*clearColor: 0.0 white, 0.0 alpha */
            //Swift.print("fill")
            layer?.backgroundColor = cgFillColor
            
        }
        
        //stroke
        let lineColor:String = style.getStyleProperty("lineColor")!.value as! String
        let lineAlpha:Double = style.getStyleProperty("lineAlpha")!.value as! Double
        let lineWidth:Int = style.getStyleProperty("lineWidth")!.value as! Int
        //Swift.print("lineColor: " + "\(lineColor)")
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))
        let cgLineColor = NSColorParser.cgColor(nsLineColor)
        //Swift.print(nsLineColor)
        if(nsLineColor != NSColor.clearColor()){/*clearColor: 0.0 white, 0.0 alpha */
            //Swift.print("line")
            layer?.borderColor = cgLineColor
            layer?.borderWidth = CGFloat(lineWidth)
        }
        //Swift.print("end of call")
    }
}