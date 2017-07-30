import Foundation
@testable import Utils

extension ProtoTypeView {
    enum WinRect {
        static let size:CGSize = CGSize(200,355)//IPhone 7: (750 x 1334) (375 x 667) ≈ (200x355)
        static let point:CGPoint = CGPoint(0,0)
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
    /**
     * Used when spacing out the buttons vertically
     */
    enum Grid{
        static let verticalSpace:CGFloat = {
            return 71//71
        }()
        static let verticalSpaces:[CGFloat] = [0,verticalSpace,WinRect.size.h/2,(WinRect.size.h) - verticalSpace]
        static func position(_ i:Int, _ size:CGSize) -> CGPoint {
            let p = CGPoint(WinRect.size.w/2,(verticalSpaces[i]).rounded())
            return p - CGPoint(size.w/2,size.h/2)
        }
    }
}
