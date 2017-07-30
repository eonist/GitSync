import Cocoa
@testable import Utils
@testable import Element

class ModalButton:ForceTouchButton{
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(ProtoTypeView.AnimState.Modal.initial, RoundedRect.DefaultEasing.easing,ProtoTypeView.Constraint.content,ProtoTypeView.Constraint.mask,self.modalFrameAnim)
    override func resolveSkin() {
        super.resolveSkin()
        addEventHandlers()
    }
    /**
     * Adds eventHandlers to UI
     */
    func addEventHandlers(){
        self.addHandler(forceTouchHandler)
    }
}
