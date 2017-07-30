import Foundation
@testable import Element
@testable import Utils

extension ElementKind {
    /**
     *
     */
    func setAppearance(_ w:CGFloat, _ h:CGFloat, _ fillet:CGFloat){
        StyleModifier.overrideStylePropVal(&self.style, ("width",0), roundedRect.w)
        StyleModifier.overrideStylePropVal(&self.style, ("height",0), roundedRect.h)
        StyleModifier.overrideStylePropVal(&self.style, ("corner-radius",0), roundedRect.fillet)
        self.modalBtn.skin?.setStyle(self.style)
    }
}
