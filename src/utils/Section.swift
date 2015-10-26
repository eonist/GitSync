import Foundation
import Cocoa

class Section:Container {
    override init(_ fillColor:NSColor = NSColor.grayColor(), _ strokeColor:NSColor = nil, _ width: Int = 100, _ height: Int = 100) {
        
        super.init(width, height)
    }
    /*
    *
    */
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        color.setFill()
        NSRectFill(dirtyRect)
    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}