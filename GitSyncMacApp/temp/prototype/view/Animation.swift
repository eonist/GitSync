import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Frame animation for promptButton
     */
//    func promptButtonAnim(point:CGPoint){
////        disableAnim {
//            self.promptBtn.setAppearance(point)
////        }
//    }
    /**
     * Frame animation for modal (buttonRect to modalRect)
     */
    func modalFrameAnim(roundedRect:RoundedRect){
        //Swift.print("roundedRect: " + "\(roundedRect)")
        Swift.print("roundedRect.w: " + "\(roundedRect.w)")
        self.modalBtn.setAppearance(roundedRect)
//        disableAnim {
        
//        }
    }
}
