import Foundation
import Cocoa
class Create {
    /**
     *
     */
    class func button(width:Int = 100,_ height:Int = 30, _ x:Int = 0, _ y:Int = 0, _ style:String = "")->NSButton{
        let button = NSButton(frame: NSRect(x: 0, y: 0, width: width, height: height))
        
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        

    }
    /**
     *
     */
    class func textButton(width:Int = 100,_ height:Int = 30, _ x:Int = 0, _ y:Int = 0, _ style:String = "", title:String = "")->NSButton{
        let button:NSButton = Create.button(width,height,x,y,style)
        button.title = title
        return button
    }
    
}