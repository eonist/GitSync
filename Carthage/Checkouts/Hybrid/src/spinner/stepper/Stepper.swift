import Foundation
/**
 * ## Examples:
 * let stepper:Stepper = .init()
 * view.addSubview(stepper)
 * stepper.onChange = {value in Swift.print("value:  \(value)")}
 */
open class Stepper: View {
   public var onChange: OnChange = { _ in Swift.print("must be set by user") }
   lazy var plusButton: Button = createPlusButton()
   lazy var minusButton: Button = createMinusButton()
   var initData: InitData
   public init(initData: InitData = Stepper.defaultData, frame: CGRect = .zero) {
      self.initData = initData
      super.init(frame: frame)
      _ = plusButton
      _ = minusButton
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
