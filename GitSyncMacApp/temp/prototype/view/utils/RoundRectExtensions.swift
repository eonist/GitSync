import Foundation
@testable import Utils

extension RoundedRect:Advancable5 {
    static var defaults:AnimState5<RoundedRect>  =  AnimState5<RoundedRect>(RoundedRect(), RoundedRect(), RoundedRect(), RoundedRect(), RoundedRect(10e-5,10e-5,10e-5,10e-5,10e-5))
    func isNear( value:  RoundedRect,  epsilon: RoundedRect) -> Bool {
        let isSizeNear = self.size.isNear(value.size,epsilon.size.w)
        let isOriginNear = self.origin.isNear(value.origin,epsilon.origin.x)
        let isFilletNear = self.fillet.isNear(value.fillet, epsilon.fillet)
        return isSizeNear && isOriginNear && isFilletNear
    }
}
