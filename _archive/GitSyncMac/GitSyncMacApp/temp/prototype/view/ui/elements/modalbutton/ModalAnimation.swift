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
        static func initial(_ i:Int) -> AnimState5<RoundedRect/*CGRect*/> {
            return .init(Modal.initial(i))
        }//set initial value
    }
}
