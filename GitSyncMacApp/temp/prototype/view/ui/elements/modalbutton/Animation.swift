import Foundation
@testable import Utils
@testable import Element

extension ModalButton {
    /**
     * Frame animation for promptButton
     */
    func promptButtonAnim(point:CGPoint){
        ProtoTypeView.shared.promptBtn.layer?.position = point
    }
    /**
     * Frame animation for modal (buttonRect to modalRect)
     */
    func modalFrameAnim(roundedRect:RoundedRect){
        ProtoTypeView.shared.modalBtn.setAppearance(roundedRect)
    }
}
