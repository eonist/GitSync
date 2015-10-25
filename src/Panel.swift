import Foundation
import Cocoa

class Panel:NSView {
    static var width = 400
    override func drawRect(dirtyRect: NSRect) {
        var pathRect = NSInsetRect(self.bounds, 1, 1);
        
        var path = NSBezierPath(roundedRect:pathRect, xRadius:10, yRadius:10);
        
        path.lineWidth = 4
        
        NSColor.greenColor().setFill();
        NSColor.blackColor().setStroke();
        path.fill()
        path.stroke()
        
        
    }
}