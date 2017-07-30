import Cocoa
@testable import Element
@testable import Utils

extension ElementKind {
    /**
     *
     */
    func setAppearance(_ roundedRect:RoundedRect){
        var style:Style = self.skin!.style as! Style
        style.describe()
        StyleModifier.overrideStylePropVal(&style, ("width",0), roundedRect.w)
        StyleModifier.overrideStylePropVal(&style, ("height",0), roundedRect.h)
        let svgPosition = Align.alignmentPoint(ProtoTypeView.Modal.svgSize, roundedRect.size, Alignment.centerCenter, Alignment.centerCenter)
        StyleModifier.overrideStylePropVal(&style, ("margin-top",1), svgPosition.y)
        StyleModifier.overrideStylePropVal(&style, ("margin-left",1), svgPosition.x)
        StyleModifier.overrideStylePropVal(&style, ("corner-radius",0), roundedRect.fillet)
        self.skin?.setStyle(style)
        self.layer?.position = roundedRect.origin
    }
    func setAppearance(_ fill:NSColor){
        var style:Style = self.skin!.style as! Style
        StyleModifier.overrideStylePropVal(&style, ("fill",0), fill)
        self.skin?.setStyle(style)
    }
}
