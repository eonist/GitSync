import Foundation
/**
 * SwitchButton
 */
open class SwitchButton: View {
   lazy var textField: Label = createTextField()
   public lazy var switchBox: Switch = createSwitch()
   let text: String
   let switchStyles: Switch.SwitchStyles
   open var selected: Bool {
      didSet {
         switchBox.selected = selected
      }
   }
   /**
    * Initiate
    */
   public init(text: String = "Test", selected: Bool = false, switchStyles: Switch.SwitchStyles = Switch.defaultSwitchStyles) {
      self.text = text
      self.selected = selected
      self.switchStyles = switchStyles
      super.init(frame: .zero)
      _ = switchBox
      _ = textField
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
