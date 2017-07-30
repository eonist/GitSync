import Cocoa
@testable import Utils
@testable import Element

class ModalButton:ForceTouchButton{
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(ProtoTypeView.AnimState.ModalButton.initial, RoundedRect.DefaultEasing.easing,ProtoTypeView.Constraint.content,ProtoTypeView.Constraint.mask,self.modalFrameAnim)
    var leftMouseDraggedMonitor:Any?/*Handler for dragging modal*/
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    var index:Int {return self.id.int}
    
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
