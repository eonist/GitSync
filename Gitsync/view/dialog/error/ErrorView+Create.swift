import Foundation
import Hybrid_macOS
import Spatial_macOS
import With_mac
/**
 * Create
 */
extension ErrorView {
   /**
    * HeaderTitle
    */
   func createHeaderLabel() -> NSLabel {
      return with(.init()) {
         $0.centerVertically()
         $0.text = "Error:"
         $0.alignment = .center
         addSubview($0)
         $0.anchorAndSize(to: self, height: 24, offset: .init(x:12, y:12), sizeOffset:.init(width: -24, height: 0))
      }
   }
   /**
    * Title
    */
   func createTitleTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Title: "
         $0.contentTextField.stringValue = "No internet connection"
         addSubview($0)
         $0.anchorAndSize(to: headerLabel, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Description
    */
   func createDescriptionTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Description: "
         $0.contentTextField.stringValue = "Gitsync is unable to reach remote server"
         addSubview($0)
         $0.anchorAndSize(to: titleTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Creates createConfirmationContainer
    */
   func createConfirmationContainer() -> ConfirmationContainer {
      return with(.init()) {
         addSubview($0)
         $0.anchorAndSize(to: descriptionTextInput, sizeTo: self, height: 32, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: 0, y: 12), sizeOffset: .init(width: -24, height: 0))
         $0.okButton.upInsideCallBack = onOkButtonClick
         $0.cancelButton.upInsideCallBack = onCancelButtonClick
      }
   }
}

