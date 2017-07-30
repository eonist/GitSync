import Foundation
@testable import Element
@testable import Utils

extension ElementKind {
    /**
     *
     */
    func setAppearance(_ element:ElementKind,_ style:inout Style,_ roundedRect:RoundedRect){
//        var style:Style = style
        StyleModifier.overrideStylePropVal(&style, ("width",0), roundedRect.w)
        StyleModifier.overrideStylePropVal(&style, ("height",0), roundedRect.h)
        StyleModifier.overrideStylePropVal(&style, ("corner-radius",0), roundedRect.fillet)
        element.skin?.setStyle(style)
    }
    
}
