import Foundation
@testable import Utils
@testable import Element

extension ModalButton {
    /**
     * Frame animation for modal (buttonRect to modalRect)
     */
    func modalFrameAnim(roundedRect:RoundedRect){
        self.setAppearance(roundedRect)
    }
}
