import Foundation
import Cocoa

class Panel:NSView {
    static var leftPadding = 12
    static var rightPadding = 12
    init() {
        let x = Table.width+Table.leftPadding+Panel.leftPadding
        let y = Table.topPadding
        let width = Win.width-Table.width-Panel.leftPadding-Panel.rightPadding
        let height = Win.height-Table.topPadding-EditMenu.height
        let rect:NSRect = NSRect(x:x, y: y, width: width,height:height)//view.bounds
        super.init(frame:rect)
    }
    required init?(coder: NSCoder) {//try to get rid of this
        fatalError("init(coder:) has not been implemented")
    }
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