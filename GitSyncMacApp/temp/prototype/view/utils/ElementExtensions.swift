import Foundation
@testable import Element
@testable import Utils

extension ElementKind {
    /**
     *
     */
    func setAppearance(_ style:inout Style,_ roundedRect:RoundedRect){
//        var style:Style = style
        StyleModifier.overrideStylePropVal(&style, ("width",0), roundedRect.w)
        StyleModifier.overrideStylePropVal(&style, ("height",0), roundedRect.h)
        StyleModifier.overrideStylePropVal(&style, ("corner-radius",0), roundedRect.fillet)
        self.skin?.setStyle(style)
        self.setAppearance(roundedRect.origin)
    }
    func setAppearance(_ point:CGPoint){
        self.layer?.position = point
    }
    func setAppearance(_ fill:NSColor){
        self.layer?.position = point
    }
    
    StyleModifier.overrideStylePropVal(&self.style, ("fill",0), NSColor.blue)
}
