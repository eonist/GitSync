import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Frame animation for promptButton
     */
    func promptButtonAnim(point:CGPoint){
        disableAnim {
            self.promptBtn.layer?.position = point
        }
    }
    /**
     * Frame animation for modal (buttonRect to modalRect)
     */
    func modalFrameAnim(roundedRect:RoundedRect){
        //anim rect here
        //Swift.print("roundedRect: " + "\(roundedRect)")
        Swift.print("roundedRect.w: " + "\(roundedRect.w)")
        disableAnim {
            self.modalBtn.setAppearance(&self.style, roundedRect)
        }
    }
}
