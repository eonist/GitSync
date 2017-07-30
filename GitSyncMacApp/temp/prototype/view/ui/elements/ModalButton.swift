import Cocoa
@testable import Utils
@testable import Element

class ModalButton:ForceTouchButton{
    lazy var modalAnimator:ElasticEaser5 = ElasticEaser5(AnimState.initial(self.index), RoundedRect.DefaultEasing.easing,ProtoTypeView.Constraint.content,ProtoTypeView.Constraint.mask,self.modalFrameAnim)
    var leftMouseDraggedMonitor:Any?/*Handler for dragging modal*/
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    lazy var index:Int = {return self.id!.int}()
    
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
    override func getClassType() -> String {
        return "\(ModalButton.self)"
    }
}
