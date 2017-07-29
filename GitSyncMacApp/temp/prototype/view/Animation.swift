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
     * Frame animation for modal
     */
    func modalFrameAnim(rect:CGRect){
        //anim rect here buttonRect to modalRect
        //Swift.print("rect: " + "\(rect)")
        disableAnim {
            StyleModifier.overrideStylePropVal(&self.style, ("width",0), rect.size.w)
            StyleModifier.overrideStylePropVal(&self.style, ("height",0), rect.size.h)
            StyleModifier.overrideStylePropVal(&self.style, ("corner-radius",0), rect.size.w/2)
            self.modalBtn.skin?.setStyle(self.style)
            self.modalBtn.layer?.position = rect.origin
        }
    }

}
