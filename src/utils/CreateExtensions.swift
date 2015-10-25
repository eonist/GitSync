import Foundation
import Cocoa
extension Create {
    /*
    * Convenince method for textButton call
    * TODO: Figure out how to use extensions for different creation methods for this item:
    */
    class func textButton(title:String)->NSButton{
        return Create.textButton(title:title)
    }
    /*
    * White button with gray border
    */
    class func simpleTextButton(title:String)->NSButton{
        let button = Create.textButton(title:title)
        (button.cell as! NSButtonCell).bordered = false
        (button.cell as! NSButtonCell).backgroundColor = NSColor.whiteColor()
        return button
    }
}