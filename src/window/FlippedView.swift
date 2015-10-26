import Cocoa
import Foundation
class FlippedView:NSView {//Organizes your view from top to bottom
    override var flipped:Bool {
        get {
            return true
        }
    }
    /*
    * Disables clipping of the view
    */
    override var wantsDefaultClipping: Bool {
        get {
            return false
        }
    }
}