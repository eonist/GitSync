import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif
/**
 * Create
 */
extension Stepper {
   /**
    * plus
    */
   func createPlusButton() -> PlusButton {
      return with(.init(style:(.white, .black, 1, true))) {
         addSubview($0)
         $0.size(to: self, axis: .hor, toAxis: .ver)
         $0.size(to: $0, axis: .ver, toAxis: .hor)
         $0.anchor(to: self)
         $0.upInsideCallBack = { self.change(amount: self.initData.increment) }
      }
   }
   /**
    * minus
    */
   func createMinusButton() -> MinusButton {
      return with(.init(style: (.white, .black, 1, true))) {
         addSubview($0)
         $0.size(to: plusButton)
         $0.anchor(to: self, align: .topRight, alignTo: .topRight)
         $0.upInsideCallBack = { self.change(amount: -self.initData.increment) }
      }
   }
}
