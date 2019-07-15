import Foundation
/**
 * Type
 */
extension Stepper {
   public typealias OnChange = (_ value: String) -> Void
   /**
    * - Parameter decimals: Decimal places
    * - Parameter increment: The amount of incrementation for each stepping
    */
   public typealias InitData = (value: CGFloat, increment: CGFloat, min: CGFloat, max: CGFloat, decimals: Int)
}
