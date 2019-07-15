import Foundation
/**
 * ## Examples:
 * let spinner:Spinner = .init()
 * addSubview(spinner)
 * spinner.onChange = {value in Swift.print("\(value)")}
 */
open class Spinner: View {
   public var onChange: OnChange = { _ in Swift.print("") }
   public lazy var textLabel: Label = createTextLabel()
   public lazy var stepper: Stepper = createStepper()
   internal let initData: Stepper.InitData
   /*Text*/
   internal var text: String
   /**
    * Initiate
    */
   public init(text: String = "Value:", initData: Stepper.InitData = Stepper.defaultData, frame: CGRect = .zero) {
      self.text = text
      self.initData = initData
      super.init(frame: frame)
      _ = stepper
      _ = textLabel
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
