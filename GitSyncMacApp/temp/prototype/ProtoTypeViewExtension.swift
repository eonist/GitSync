import Foundation
@testable import Utils
@testable import Element

extension ProtoTypeView {
    
    enum WinRect {
        static let size:CGSize = CGSize(200,355)
        static let point:CGPoint = CGPoint(0,0)
    }
    enum Modal {
        static let initial:CGRect = {//init modal btn size
            let size:CGSize = CGSize(100,100)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        static let click:CGRect = {//when modalBtn is pressed down
            let size:CGSize = Modal.initial.size * 0.75
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        static let expanded:CGRect = {//when modal is in expanded mode
            let size = CGSize(WinRect.size.w,WinRect.size.w) - CGSize(40,0)
            let p:CGPoint = Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
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
    
}
