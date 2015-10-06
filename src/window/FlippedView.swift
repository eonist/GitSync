import Cocoa
import Foundation
class FlippedView: NSView {
    override var flipped:Bool {
        get {
            return true
        }
    }
}