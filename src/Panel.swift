import Foundation
import Cocoa

class Panel:NSView {
    static var leftPadding = 12
    static var rightPadding = 12
    override func drawRect(dirtyRect: NSRect) {
        let pathRect = NSInsetRect(self.bounds, 1, 1);
        
        let path = NSBezierPath(roundedRect:pathRect, xRadius:0, yRadius:0);
        
        path.lineWidth = 1
        
        NSColor.whiteColor().setFill();
        NSColor.grayColor().setStroke();
        path.fill()
        path.stroke()
        
        
    }
}