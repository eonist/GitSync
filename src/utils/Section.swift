import Foundation
import Cocoa

class Section:Container {
    var fillColor:NSColor = NSColor.clearColor()
    var strokeColor:NSColor = NSColor.clearColor()
    init(_ fillColor:NSColor = NSColor.clearColor(), _ strokeColor:NSColor = NSColor.clearColor(), _ width: Int = 100, _ height: Int = 100) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        super.init(width, height)
    }
    /*
    *
    */
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if(fillColor != NSColor.clearColor()){
            fillColor.setFill()
           
        }
         NSRectFill(dirtyRect)
        if(strokeColor != NSColor.clearColor()){
            strokeColor.setStroke()
            
        }
        
    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}