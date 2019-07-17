import Cocoa
import Hybrid_macOS
/**
 * TextInput
 */
class OptionInput: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var checkButton: CheckButton = createCheckBox()
   override public init(frame: CGRect) {
      Swift.print("OptionInput.init")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      //      self.layer?.backgroundColor = NSColor.clear.cgColor
      _ = descriptionLabel
      _ = checkButton
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

