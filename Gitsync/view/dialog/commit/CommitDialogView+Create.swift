import Foundation
import Hybrid_macOS
import Spatial_macOS
import With_mac
/**
 * Create
 */
extension CommitDialogView {
   /**
    * HeaderTitle
    */
   func createHeaderTitleLabel() -> NSLabel {
      return with(.init()) {
         $0.centerVertically()
         $0.text = "Commit message:"
         $0.alignment = .center
         addSubview($0)
         $0.anchorAndSize(to: self, height: 24, offset: .init(x:12, y:12), sizeOffset:.init(width: -24, height: 0))
      }
   }
   /**
    * Repo
    */
   func createRepoTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Repository: "
         $0.contentTextField.stringValue = "Gitsync"
         addSubview($0)
         $0.anchorAndSize(to: headerTitle, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Title
    */
   func createTitleTextInput() -> TextInput {
      return with(.init()) {
         addSubview($0)
         $0.descriptionLabel.text = "Title: "
         $0.contentTextField.stringValue = "Fix bug"
         $0.anchorAndSize(to: repoTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: 0, y: 12), sizeOffset: .init(width: -24, height: 0))
      }
   }
   /**
    * Description
    */
   func createDescriptionTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Description: "
         $0.contentTextField.stringValue = "Fixes issue with bug"
         addSubview($0)
         $0.anchorAndSize(to: titleTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x: 0, y: 12), sizeOffset: .init(width: -24, height:0))
      }
   }
//   func createDescriptionTextField() -> NSTextField {
//      return with(.init()) {
//         $0.activateAnchorAndSize { view in
//            let tl = Constraint.anchor(view, to: descriptionLabel, align:.topLeft, alignTo: bottomLeft, offset: .init(x:0, y:12))
//            let br = Constraint.anchor(view, to: descriptionLabel, align:.bottomRight, alignTo: bottomRight, offset: .init(x:-12, y:-12))
//            return [tl,br]
//         }
//         addSubView($0)
//      }
//   }
   /**
    * Creates createConfirmationContainer
    */
//   func createConfirmationContainer() -> ConfirmationContainer {
//      with(.init()) {
//         $0.anchorAndSize(to: descriptionTextField, sizeTo: descriptionTextField, height:32, align: .topLeft, alignTo: .bottomLeft, offset:.init(x:0,y:12))
//         $0.okButton.onClick = onOKButtonClick
//         $0.cancelButton.onClick = onCancelButtonClick
//         addSubview($0)
//      }
//   }
}
