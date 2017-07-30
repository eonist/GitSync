import Cocoa
@testable import Utils
@testable import Element
/**
 * Constants (Metrics)
 * TODO: move into enum named Sizes? 
 */
extension ProtoTypeView {
    
    enum Constraint{
        static let mask:ElasticEaser5.Frame = (WinRect.point.y,WinRect.size.h)
        static let content:ElasticEaser5.Frame = (Modal.expanded.y,Modal.expanded.h)
    }
    enum AnimState{
        enum Modal{
            static var initial:AnimState5<RoundedRect/*CGRect*/> {return .init(ProtoTypeView.Modal.initial)}//set initial value
        }
        enum PromptButton{
            static var initial:AnimState5<CGPoint> {return .init(ProtoTypeView.PromptButton.initial.origin)}//set initial value
        }
    }
}
