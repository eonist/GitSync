import Cocoa
@testable import Utils

extension ProtoTypeView{
    enum Colors{
        enum Modal {
            static let initial:NSColor = "#66CDAD".nsColor
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
