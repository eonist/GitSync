import Cocoa
@testable import Utils

extension ProtoTypeView{
    enum Colors{
        enum Modal {//TODO: ⚠️️ move these into the scope of ModalButton
            static func initial(_ i:Int) -> NSColor {
                if i == 1 {return "#66CDAD".nsColor}
                else if i == 2 {return "#EB4D62".nsColor}
                else /*if i == 3*/ {return "#4E98F5".nsColor}
            }
            static let click:NSColor = "#555555".nsColor
            static func expanded(_ i:Int)-> NSColor {return initial(i)}
//            enum UnFocused{
//                static func background(_ i:Int) -> NSColor {
//                    return Modal.initial(i).alpha(0.2)
//                }
//                //static let svg:NSColor = NSColor.white.alpha(0.3)
//            }
        }
        enum PromptButton {
            enum Background{
                static let idle:NSColor = "#DDDDDD".nsColor
                static let down:NSColor = "#66CDAD".nsColor
            }
            enum Text{
                static let idle:NSColor = "#555555".nsColor
                static let down:NSColor = "#FFFFFF".nsColor
            }
        }
    }
}
