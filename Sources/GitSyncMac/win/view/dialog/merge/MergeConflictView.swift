class MergeConflictView {
	lazy var headerLabel: Label = createHeaderLabel()
	lazy var issueLabel: Label = createIssueLabel()
	lazy var fileLabel: Label = createFileLabel()
	lazy var repoLabel: Label = createRepoLabel()
	lazy var keepLocalOptionInput: OptionInput = createKeepLocalOptionInput()
	lazy var keepRemoteOptionInput: OptionInput = createKeepRemoteOptionInput()
	lazy var keepMixedOptionInput: OptionInput = createKeepMixedOptionInput()
	lazy var applyToAllConflictsCheckBoxInput: CheckBoxInput = createApplyToAllConflictsCheckBoxInput()
	lazy var applyToAllReposCheckBoxInput: CheckBoxInput = createApplyToAllReposCheckBoxInput()
	lazy var confirmationContainer: CheckBoxInput = createConfirmationContainer()
	/**
    * Init
    */
	init() {
		headerLabel.setText("Resolve merge conflict:")
		issueLabel.setText("Conflict: Remote is newer than local")
		fileLabel.setText("File: /Doc/Dev/Gitsync/App.swift")
		repoLabel.setText("Repository: Gitsync")
		keepLocalOptionInput.titleLabel.setText("Keep local version:")
		keepRemoteOptionInput.titleLabel.setText("Keep remote version:")
		keepMixedOptionInput.titleLabel.setText("Keep mix of both versions:")
		applyToAllConflictsCheckBoxInput.titleLabel.setText("Apply to all conflicts:")
		applyToAllReposCheckBoxInput.titleLabel.setText("Apply to all repos:")
		_ = confirmationContainer
	}
}
