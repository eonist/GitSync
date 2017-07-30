import Foundation
@testable import Utils
@testable import Element

enum Modal {
    static let svgSize:CGSize = CGSize(50,50)//the graphic
    static func initial(_ i:Int = 0) -> RoundedRect /*CGRect*/  {//init modal btn size
        let size:CGSize = CGSize(100,100)
        let p:CGPoint = ProtoTypeView.Grid.position(i,size)//Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = 50
        return RoundedRect(p,size,fillet)
        //return CGRect(p,size)
    }
    static func click(_ i:Int) -> RoundedRect {//when modalBtn is pressed down
        let size:CGSize = Modal.initial().size * 0.75
        let p:CGPoint = ProtoTypeView.Grid.position(1,size)//Align.alignmentPoint(size, WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = Modal.initial().fillet * 0.75
        return RoundedRect(p,size,fillet)
    }
    static let expanded:RoundedRect = {//when modal is in expanded mode
        let size = CGSize(ProtoTypeView.WinRect.size.w,ProtoTypeView.WinRect.size.w) - CGSize(40,0)
        let p:CGPoint = Align.alignmentPoint(size, ProtoTypeView.WinRect.size, Alignment.centerCenter, Alignment.centerCenter)
        let fillet:CGFloat = 20
        return RoundedRect(p,size,fillet)
    }()
}
