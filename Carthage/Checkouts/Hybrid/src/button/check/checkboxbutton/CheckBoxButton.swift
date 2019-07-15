import Foundation
/**
 * CheckBoxButton
 */
open class CheckBoxButton: View {
   lazy var textField: Label = createTextField()
   public lazy var checkBox: CheckButton = createCheckBox()
   let text: String
   let checkBoxStyles: CheckButton.CheckBtnStyles
   open var selected: Bool {
      didSet {
         checkBox.selected = selected
      }
   }
   /**
    * Initiate
    */
   public init(text: String, selected: Bool, checkBoxStyles: CheckButton.CheckBtnStyles) {
      self.text = text
      self.selected = selected
      self.checkBoxStyles = checkBoxStyles
      super.init(frame: .zero)
      _ = checkBox
      _ = textField
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
