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
        //let svgPosition = Align.alignmentPoint(ProtoTypeView.Modal.svgSize, roundedRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let marginTop:CGFloat = (roundedRect.h/2)-(ProtoTypeView.Modal.svgSize.h/2)
        let marginLeft:CGFloat = (roundedRect.w/2)-(ProtoTypeView.Modal.svgSize.w/2)
        StyleModifier.overrideStylePropVal(&style, ("margin-top",1), marginTop)
        StyleModifier.overrideStylePropVal(&style, ("margin-left",1), marginLeft)
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
