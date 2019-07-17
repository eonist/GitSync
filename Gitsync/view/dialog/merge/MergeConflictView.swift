import Cocoa
import Hybrid_macOS
import With_mac
import Spatial_macOS
/**
 * MergeConflictView
 */
class MergeConflictView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   /*UI*/
   lazy var headerLabel: NSLabel = createHeaderLabel()
   lazy var issueTextInput: TextInput = createIssueTextInput()
   lazy var fileTextInput: TextInput = createfileTextInput()
   lazy var repoTextInput: TextInput = createRepoTextInput()
   lazy var keepLocalOptionInput: OptionInput = createKeepLocalOptionInput()
   lazy var keepRemoteOptionInput: OptionInput = createKeepRemoteOptionInput()
   lazy var keepMixedOptionInput: OptionInput = createKeepMixedOptionInput()
   lazy var applyToAllConflictsCheckBoxInput: OptionInput = createApplyToAllConflictsCheckBoxInput()
   lazy var applyToAllReposCheckBoxInput: OptionInput = createApplyToAllReposCheckBoxInput()
   lazy var confirmationContainer: ConfirmationContainer = createConfirmationContainer()
   /**
    * Init
    */
   override public init(frame: CGRect) {
      Swift.print("CommitDialogView.init")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      /*UI*/
      _ = headerLabel//.setText("Resolve merge conflict:")
      _ = issueTextInput//.setText("Conflict: Remote is newer than local")
      _ = fileTextInput//.setText("File: /Doc/Dev/Gitsync/App.swift")
      _ = repoTextInput//.setText("Repository: Gitsync")
      _ = keepLocalOptionInput//.titleLabel.setText("Keep local version:")
      _ = keepRemoteOptionInput//.titleLabel.setText("Keep remote version:")
      _ = keepMixedOptionInput//.titleLabel.setText("Keep mix of both versions:")
//      let selectGroup:SelectGroup = .init(selectables: views, selected: btn1)
      // views.forEach{ view in view.tapUpInsideCallBack = {selectGroup.selected = view}}
      _ = applyToAllConflictsCheckBoxInput//.titleLabel.setText("Apply to all conflicts:")
      _ = applyToAllReposCheckBoxInput//.titleLabel.setText("Apply to all repos:")
      _ = confirmationContainer
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
