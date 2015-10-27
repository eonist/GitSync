import Foundation
import Cocoa

class Section:Container {//Unlike Container, section can have a style applied
    var style:IStyle
    init(_ style:IStyle, _ width: Int = 100, _ height: Int = 100) {
        self.style = style
        super.init(width, height)
        self.wantsLayer = true
        
        
        
        //continue here
        //use updateLyer method instead
        
        
        
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
    /*
    *
    */
    /*
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if(fillColor != NSColor.clearColor()){
            let fillColor = NSColorParser.cgColor(self.fillColor)
            layer?.backgroundColor = fillColor//CGColorCreateGenericRGB(1, 0, 1, 1)
        }
        if(strokeColor != NSColor.clearColor()){
            let strokeColor = NSColorParser.cgColor(self.strokeColor)
            layer?.borderColor = strokeColor//CGColorCreateGenericRGB(0, 1, 0, 1)
            layer?.borderWidth = 1
        }
    }
*/
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}