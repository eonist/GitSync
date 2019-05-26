import Foundation
@testable import Utils
@testable import Element

enum Modal {
    static let svgSize:CGSize = {
        return CGSize(initial().size.w/2,initial().size.h/2)//the graphic
    }()
    static func initial(_ i:Int = 0) -> RoundedRect /*CGRect*/  {//init modal btn size
        let size:CGSize = CGSize(80,80)
        let p:CGPoint = ProtoTypeView.Grid.position(i,size)//Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = size.w/2
        return RoundedRect(p,size,fillet)
        //return CGRect(p,size)
    }
    static func click(_ i:Int) -> RoundedRect {//when modalBtn is pressed down
        let size:CGSize = Modal.initial().size * 1.25
        let p:CGPoint = ProtoTypeView.Grid.position(i,size)//Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = Modal.initial().fillet * 1.25
        return RoundedRect(p,size,fillet)
    }
    static let expanded:RoundedRect = {//when modal is in expanded mode
        let size = CGSize(ProtoTypeView.WinRect.size.w,ProtoTypeView.WinRect.size.w) + CGSize(-40,40)
        let p:CGPoint = Align.alignmentPoint(size, ProtoTypeView.WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = 20
        return RoundedRect(p,size,fillet)
    }()
}
