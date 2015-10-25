import Foundation
import Cocoa

class Align {
    /**
     * General interface horizontal align method
     */
    class func horizontally(elements:Array<NSView>, _ alignType:String = "center", _ viewWidth:Int = 0, _ xOffset:Int = 0 , _ yOffset:Int = 0,_ horisontalSpacing:Int = 0){
        var totalWidth:Int = 0//(buttons.count * buttonWidth) + (buttonSpacing * (buttons.count-1))
        for elmnt:NSView in elements {//find the total width
            totalWidth += Int(elmnt.frame.width) + (elmnt != elements.last ? horisontalSpacing : 0)
        }
        
        var tempX:Int = xOffset
        
        switch alignType{
            case "left":
                tempX += 0
            case "center":
                tempX += (viewWidth/2) - (totalWidth/2)
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
    /**
    *
    */
    class func vertically(elements:Array<NSView>, _ alignType:String = "top", _ viewHeight:Int = 0, _ xOffset:Int = 0 , _ yOffset:Int = 0,_ verticalSpacing:Int = 0){
        
    }

}