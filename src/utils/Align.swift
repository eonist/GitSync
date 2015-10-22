import Foundation
import Cocoa

class Align {
    /**
    *
    */
    class func horizontalAlignElements(elements:Array<NSView>,_ viewWidth:Int, _ yOffset:Int,_ horisontalSpacing:Int){
        var totalWidth:Int = 0//(buttons.count * buttonWidth) + (buttonSpacing * (buttons.count-1))
        for elmnt:NSView in elements {//find the total width
            totalWidth += Int(elmnt.frame.width) + (elmnt != elements.last ? horisontalSpacing : 0)
        }
        
        var tempX:Int = (viewWidth/2) - (totalWidth/2)
        
        
        for element:NSView in elements{//align elements
            let x:Int = tempX
            let y:Int = yOffset
            
            element.setFrameOrigin(NSPoint(x: x, y: y))
            tempX += Int(element.frame.width) + buttonSpacing
            
        }
    }

}