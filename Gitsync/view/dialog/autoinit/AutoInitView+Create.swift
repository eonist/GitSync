import Foundation
import Hybrid_macOS
import Spatial_macOS
import With_mac
 
extension AutoInitView {
   /**
    * HeaderTitle
    */
   func createHeaderLabel() -> NSLabel {
      return with(.init()) {
         $0.centerVertically()
         $0.text = "Auto init:"
         $0.alignment = .center
         addSubview($0)
         $0.anchorAndSize(to: self, height: 24, offset: .init(x:12, y:12), sizeOffset:.init(width: -24, height: 0))
      }
   }
   /**
    * Issue
    */
   func createIssueTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Issue: "
         $0.contentTextField.stringValue = "Remote is newer than local"
         addSubview($0)
         $0.anchorAndSize(to: headerLabel, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Proposal
    */
   func createProposalTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Proposal: "
         $0.contentTextField.stringValue = "Do you want to overwrite the folder"
         addSubview($0)
         $0.anchorAndSize(to: issueTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Creates createConfirmationContainer
    */
   func createConfirmationContainer() -> ConfirmationContainer {
      return with(.init()) {
         addSubview($0)
         $0.anchorAndSize(to: proposalTextInput, sizeTo: self, height: 32, align: .topLeft, alignTo: .bottomLeft, offset: .init(x: 0, y: 12), sizeOffset: .init(width: -24, height: 0))
         $0.okButton.upInsideCallBack = onOkButtonClick
         $0.cancelButton.upInsideCallBack = onCancelButtonClick
      }
   }
}
