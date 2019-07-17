import Cocoa
import Hybrid_macOS
/**
 * CommitView
 */
class CommitDialogView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var headerTitle: NSLabel = createHeaderTitleLabel()
   lazy var repoTextInput: TextInput = createRepoTextInput()
//   lazy var repoTextField: NSTextField = createTextField()
   lazy var titleTextInput: TextInput = createTitleTextInput()
//   lazy var titleTextField: NSTextField = createTitleTextField()
   lazy var descriptionTextInput: TextInput = createDescriptionTextInput()
//   lazy var descriptionTextField: NSLabel = createDescriptionTextField()
   /*Confirmation buttons*/
   lazy var confirmationContainer: ConfirmationContainer = createConfirmationContainer()
   override public init(frame: CGRect) {
      Swift.print("CommitDialogView.init")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = headerTitle
      _ = repoTextInput
      _ = titleTextInput
      _ = descriptionTextInput
      _ = confirmationContainer
      
//      repoLabel.setText("Repository: ")
//      repoTextField.setText(repoName)
//      titleLabel.setText("Title: ")
//      titleTextField.setText(title)
//      descriptionLabel.setText("Description: ")
//      descriptionTextField.setText(description)
//      _ = confirmationContainer
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

