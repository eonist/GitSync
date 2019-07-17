import Cocoa
import Hybrid_macOS
/**
 * ErrorView
 */
class ErrorView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var headerLabel: NSLabel = createHeaderLabel()
   lazy var titleTextInput: TextInput = createTitleTextInput()
   lazy var descriptionTextInput: TextInput = createDescriptionTextInput()
   lazy var confirmationContainer: ConfirmationContainer = createConfirmationContainer()
   override public init(frame: CGRect) {
      Swift.print("AutoInitView.init")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = headerLabel//.setText("")
      
      _ = confirmationContainer
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

