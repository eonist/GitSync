import Cocoa
@testable import Element
@testable import Utils

extension ElementKind {
    /**
     *
     */
    func setAppearance(_ roundedRect:RoundedRect){
//        var style:Style = style
        var style:Style = self.skin!.style as! Style
        StyleModifier.overrideStylePropVal(&style, ("width",0), roundedRect.w)
        StyleModifier.overrideStylePropVal(&style, ("height",0), roundedRect.h)
        StyleModifier.overrideStylePropVal(&style, ("corner-radius",0), roundedRect.fillet)
        self.skin?.setStyle(style)
        self.setAppearance(roundedRect.origin)
    }
    func setAppearance(_ point:CGPoint){
        disableAnim {
            self.layer?.position = point
        }
        
    }
    func setAppearance(_ fill:NSColor){
        var style:Style = self.skin!.style as! Style
        StyleModifier.overrideStylePropVal(&style, ("fill",0), fill)
        self.skin?.setStyle(style)
    }
    
    
}
