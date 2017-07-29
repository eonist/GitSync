import Cocoa
@testable import Utils
@testable import Element
/**
 * Constants
 */
extension ProtoTypeView {
    enum WinRect {
        static let size:CGSize = CGSize(200,355)//IPhone 7: (750 x 1334) (375 x 667) ≈ (200x355)
        static let point:CGPoint = CGPoint(0,0)
    }
    enum Modal {
        static let initial:RoundedRect/*CGRect*/ = {//init modal btn size
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            let fillet:CGFloat = 50
            return RoundedRect(p,size,fillet)
            //return CGRect(p,size)
        }()
        static let click:RoundedRect = {//when modalBtn is pressed down
            let size:CGSize = Modal.initial.size * 0.75
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            let fillet:CGFloat = Modal.initial.fillet * 0.75
            return RoundedRect(p,size,fillet)
        }()
        static let expanded:RoundedRect = {//when modal is in expanded mode
            let size = CGSize(WinRect.size.w,WinRect.size.w) - CGSize(40,0)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            let fillet:Fillet = Fillet(20)
            return RoundedRect(p,size)
        }()
    }
    enum PromptButton {
        static let initial:CGRect = {
            let size:CGSize = CGSize(Modal.expanded.size.w,45)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.bottomCenter, Alignment.topCenter)
            return CGRect(p,size)
        }()
        static let expanded:CGPoint = {//the limit of where promptButton can go vertically
            return initial.origin - CGPoint(0,initial.height + 20/*<--bottom margin*/)
        }()
    }
    enum Constraint{
        static let mask:ElasticEaser5.Frame = (WinRect.point.y,WinRect.size.h)
        static let content:ElasticEaser5.Frame = (Modal.expanded.y,Modal.expanded.h)
    }
    enum AnimState{
        enum PromptButton{
            static var initial:AnimState5<CGPoint> {return .init(ProtoTypeView.PromptButton.initial.origin)}//set initial value
        }
        enum Modal{
            static var initial:AnimState5<RoundedRect/*CGRect*/> {return .init(ProtoTypeView.Modal.initial)}//set initial value
        }
    }
}
