import Foundation
import Cocoa
class Create {
    /**
     *
     */
    class func button(width:Int = 100,_ height:Int = 30, _ x:Int = 0, _ y:Int = 0, _ bezelStyle:NSBezelStyle = NSBezelStyle.SmallSquareBezelStyle)->NSButton{
        let button = NSButton(frame: NSRect(x: 0, y: 0, width: width, height: height))
        
        //button.highlight(true)
        let buttonCell:NSButtonCell = button.cell! as! NSButtonCell
        buttonCell.bezelStyle = bezelStyle//NSBezelStyle.SmallSquareBezelStyle//NSBezelStyle.RoundedBezelStyle
        
        return button
        
    }
    /**
     *
     */
    class func textButton(width:Int = 100,_ height:Int = 30, _ x:Int = 0, _ y:Int = 0, _ bezelStyle:NSBezelStyle = NSBezelStyle.SmallSquareBezelStyle, title:String = "")->NSButton{
        let button:NSButton = Create.button(width,height,x,y,bezelStyle)
        button.title = title
        return button
    }
    
}


/*
case RoundedBezelStyle
case RegularSquareBezelStyle
case ThickSquareBezelStyle
case ThickerSquareBezelStyle
case DisclosureBezelStyle
case ShadowlessSquareBezelStyle
case CircularBezelStyle
case TexturedSquareBezelStyle
case HelpButtonBezelStyle
case SmallSquareBezelStyle
case TexturedRoundedBezelStyle
case RoundRectBezelStyle
case RecessedBezelStyle
case RoundedDisclosureBezelStyle
// The inline bezel style contains a solid round-rect border background. It can be used to create an "unread" indicator in an outline view, or another inline button in a tableview, such as a stop progress button in a download panel. Use text for an unread indicator, and a template image for other buttons.
@available(OSX 10.7, *)
case InlineBezelStyle

*/