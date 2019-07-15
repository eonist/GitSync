import Foundation
/**
 * Core
 */
extension Stepper {
   /**
    * Change
    */
   func change(amount: CGFloat) {
      let newVal: CGFloat = initData.value + amount
      let minVal: CGFloat = min(newVal, initData.max)/*Cap the value from min to max*/
      let maxVal: CGFloat = max(minVal, initData.min)
      initData.value = maxVal
      let strVal: String = .init(format: "%.0\(initData.decimals)f", maxVal)/*The value must have no more than the value of the _decimals*/
      onChange(strVal)
   }
}
