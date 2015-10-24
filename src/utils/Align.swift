import Foundation
import Cocoa

class Align {
    /**
     * General interface horizontal align method
     */
    class func horizontal(elements:Array<NSView>, alignType:String = "center", _ viewWidth:Int = 0, xOffset:Int = 0 , _ yOffset:Int = 0,_ horisontalSpacing:Int = 0){
        var totalWidth:Int = 0//(buttons.count * buttonWidth) + (buttonSpacing * (buttons.count-1))
        for elmnt:NSView in elements {//find the total width
            totalWidth += Int(elmnt.frame.width) + (elmnt != elements.last ? horisontalSpacing : 0)
        }
        
        var tempX:Int = 0
        
        switch alignType{
            case "left":
                tempX = 0
            case "center":
                tempX = (viewWidth/2) - (totalWidth/2)
            default:
                break;
            
        }
       
        
        
        for element:NSView in elements{//align elements
            let x:Int = tempX
            let y:Int = yOffset
            
            element.setFrameOrigin(NSPoint(x: x, y: y))
            tempX += Int(element.frame.width) + horisontalSpacing
            
        }
    }

}