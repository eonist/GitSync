import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle = Style.clear
    var skinState:String = SkinStates.down
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
    * Temp until you can access syle from an extension
    */
    func setStyle(style:IStyle){
        self.style = style
    }
    /**
    * Returns the class type of the Class instance
    * @Note if a class subclasses Element that sub-class will be the class type
    * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
    */
    func getClassType()->String{
        return String(Element)
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
        //print("Obj name: " + "\((self as! NSObject).className)")
        //print("Obj name: " + "\(String(self))")
        setStyle(StyleManager.getStyle(getClassType())!)
        var fillColor:String = style.getStyleProperty("fillColor")!.value as! String
        var fillAlpha:Double = style.getStyleProperty("fillAlpha")!.value as! Double
        var lineColor:String = style.getStyleProperty("lineColor")!.value as! String
        var lineAlpha:Double = style.getStyleProperty("lineAlpha")!.value as! Double
        var lineWidth:Int = style.getStyleProperty("lineWidth")!.value as! Int
        
        //TODO: find the code that creates the styleprop names like: downFillColor or create one
        
        switch skinState{
            case SkinStates.none:
                Swift.print("none")
            case SkinStates.down:
                Swift.print("down")
                fillColor = style.getStyleProperty("downFillColor")!.value as! String
                fillAlpha = style.getStyleProperty("downFillAlpha")!.value as! Double
                lineColor = style.getStyleProperty("downLineColor")!.value as! String
                lineAlpha = style.getStyleProperty("downLineAlpha")!.value as! Double
                lineWidth = style.getStyleProperty("downLineWidth")!.value as! Int
            default:
                break;
        }
        //fill
        
        //Swift.print("fillColor: " + "\(fillColor)")
        let nsFillColor = ColorParser.nsColor(fillColor, Float(fillAlpha))
        
        //stroke
        let nsLineColor = ColorParser.nsColor(lineColor, Float(lineAlpha))
        
        ViewModifier.applyColor(layer!, nsFillColor, nsLineColor, lineWidth)
    }
}