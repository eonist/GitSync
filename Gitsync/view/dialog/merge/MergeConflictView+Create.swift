import Cocoa
import Hybrid_macOS
import With_mac
import Spatial_macOS

extension MergeConflictView {
   /**
    * HeaderTitle
    */
   func createHeaderLabel() -> NSLabel {
      return with(.init()) {
         $0.centerVertically()
         $0.text = "Merge conflict:"
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
    * File
    */
   func createfileTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "File: "
         $0.contentTextField.stringValue = "Readme.md"
         addSubview($0)
         $0.anchorAndSize(to: issueTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Repo
    */
   func createRepoTextInput() -> TextInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Repo: "
         $0.contentTextField.stringValue = "Gitsync"
         addSubview($0)
         $0.anchorAndSize(to: fileTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Local
    */
   func createKeepLocalOptionInput() -> OptionInput {
      return with(.init()){
          $0.descriptionLabel.text = "Keep local version: "
          addSubview($0)
         $0.anchorAndSize(to: repoTextInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
        
      }
   }
   /**
    * Remote
    */
   func createKeepRemoteOptionInput() -> OptionInput {
      return with(.init()) {
          $0.descriptionLabel.text = "Keep remote version: "
         addSubview($0)
         $0.anchorAndSize(to: keepLocalOptionInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Mixed
    */
   func createKeepMixedOptionInput() -> OptionInput {
      return with(.init()) {
          $0.descriptionLabel.text = "Keep mix of both versions: "
         addSubview($0)
         $0.anchorAndSize(to: keepRemoteOptionInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * All conflicts
    */
   func createApplyToAllConflictsCheckBoxInput() -> OptionInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Apply to all conflicts: "
         addSubview($0)
         $0.anchorAndSize(to: keepMixedOptionInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * All repos
    */
   func createApplyToAllReposCheckBoxInput() -> OptionInput {
      return with(.init()) {
         $0.descriptionLabel.text = "Apply to all repos: "
         addSubview($0)
         $0.anchorAndSize(to: applyToAllConflictsCheckBoxInput, sizeTo: self, height: 24, align: .topLeft, alignTo:.bottomLeft, offset: .init(x:0, y:12), sizeOffset:.init(width:-24,height:0))
      }
   }
   /**
    * Creates createConfirmationContainer
    */
   func createConfirmationContainer() -> ConfirmationContainer {
      return with(.init()) {
         addSubview($0)
         $0.anchorAndSize(to: applyToAllReposCheckBoxInput, sizeTo: self, height:32, align: .topLeft, alignTo: .bottomLeft, offset:.init(x:0,y:12),sizeOffset: .init(width: -24, height:0))
         $0.okButton.upInsideCallBack = onOkButtonClick
         $0.cancelButton.upInsideCallBack = onCancelButtonClick
      }
   }
}

//func () -> CheckBoxInput {
//   with(.init()){
//      $0.anchorAndSize(to:keepMixedOptionInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
//      addSubview($0)
//   }
//}
//func () -> CheckBoxInput {
//   with(.init()){
//      $0.anchorAndSize(to:allConflictsCheckBoxInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
//      addSubview($0)
//   }
//}
