/**
 * Create
 */
extension MergeConflictView {
	func createHeaderLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:self,align:.topLeft,alignTo:.topLeft,offset:.init(x:0,y:12)sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createIssueLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:headerLabel,sizeTo: self, align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12),sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createFileLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:issueLabel,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createRepoLabel() -> Label {
		with(.init()){
			$0.anchorAndSize(to:fileLabel,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createKeepLocalOptionInput() -> OptionInput {
		with(.init()){
			$0.anchorAndSize(to:repoLabel,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createKeepRemoteOptionInput() -> OptionInput {
		with(.init()){
			$0.anchorAndSize(to:keepLocalOptionInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createKeepMixedOptionInput() -> OptionInput {
		with(.init()){
			$0.anchorAndSize(to:keepRemoteOptionInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createApplyToAllConflictsCheckBoxInput() -> CheckBoxInput {
		with(.init()){
			$0.anchorAndSize(to:keepMixedOptionInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createApplyToAllReposCheckBoxInput() -> CheckBoxInput {
		with(.init()){
			$0.anchorAndSize(to:allConflictsCheckBoxInput,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12), sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createConfirmationContainer() -> ConfirmationContainer {
		with(.init()) {
			$0.anchorAndSize(to:applyToAllReposCheckBoxInput,align:topLeft,alignTo:bottomLeft,offset:.init(x:0,y:12),sizeOffset:.init(width:-24,height:0))
			$0.okButton.onClick = onOKButtonClick
			$0.cancelButton.onClick = onCancelButtonClick
			addSubview($0)
		}
	}
}
