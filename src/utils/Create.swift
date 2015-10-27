import Foundation
import Cocoa
class Create {
    /**
     *
     */
    /*
    class func button(width:Int = 100,_ height:Int = 30, _ x:Int = 0, _ y:Int = 0, _ bezelStyle:NSBezelStyle = NSBezelStyle.SmallSquareBezelStyle)->NSButton{
        let button = Button(width,height,GraphicStyle.green)
        return button
        
    }
    */
    /**
     *
     */
    /*
    class func textButton(width:Int = 100, height:Int = 22,  x:Int = 0,  y:Int = 0,  bezelStyle:NSBezelStyle = NSBezelStyle.SmallSquareBezelStyle,   title:String = "")->NSButton{
        let button:NSButton = Create.button(width,height,x,y,bezelStyle)
        button.title = title
        return button
    }
    */
}
extension Create {
    /*
    * Convenince method for textButton call
    * TODO: Figure out how to use extensions for different creation methods for this item:
    */
    /*
    class func textButton(title:String)->NSButton{
        return Create.textButton(title:title)
    }
*/
    /*
    * White button with gray border
    */
    /*
    class func simpleTextButton(title:String)->NSButton{
        let button = Create.textButton(title:title)
        (button.cell as! NSButtonCell).bordered = true
        (button.cell as! NSButtonCell).backgroundColor = NSColor.whiteColor()
        return button
    }
*/
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