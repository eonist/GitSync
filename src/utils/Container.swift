import Foundation
import Cocoa

class Container:NSView{
    init(_ width:Int = 300, _ height:Int = 30) {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        
    }
    override func drawRect(var dirtyRect: NSRect)  {
        
        dirtyRect = NSRect(x: 0, y: 0, width: 500, height: 500)
        super.drawRect(dirtyRect)
    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    * This makes sure that the view draws from top left corner
    */
    override var flipped:Bool {
        get {
            return true
        }
    }
}