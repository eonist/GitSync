import Foundation
@testable import Utils

extension RoundRect:Advancable5 {
    static var defaults:AnimState5<RoundRect>  =  AnimState5<RoundRect>(RoundRect(), RoundRect(), RoundRect(), RoundRect(), RoundRect(10e-5,10e-5,10e-5,10e-5,Fillet()))
    func isNear( value:  CGRect,  epsilon: CGRect) -> Bool {
        return self.size.isNear(value.size,epsilon.size.w) && self.origin.isNear(value.origin,epsilon.origin.x)
    }
}
