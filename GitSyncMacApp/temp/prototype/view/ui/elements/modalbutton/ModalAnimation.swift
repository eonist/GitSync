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
    enum AnimState{
        enum ModalButton{
            static var initial:AnimState5<RoundedRect/*CGRect*/> {return .init(Modal.initial)}//set initial value
        }
    }
}
