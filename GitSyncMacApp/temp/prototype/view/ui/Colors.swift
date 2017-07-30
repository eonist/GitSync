import Cocoa
@testable import Utils

extension ProtoTypeView{
    enum Colors{
        enum Modal {
            static func initial(_ i:Int) -> NSColor {
                if i == 1 {return "#66CDAD".nsColor}
                else if i == 2 {return "#EB4D62".nsColor}
                else /*if i == 3*/ {return "#4E98F5".nsColor}
            }
            static let click:NSColor = "#555555".nsColor
            static let expanded:NSColor = "#66CDAD".nsColor
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
