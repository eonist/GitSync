extension AutoInitView {
	func createHeaderLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:self,align:topLeft,alignTo:topLeft,offset:.init(x:0,y:12)sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createIssueLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:headerLabel,sizeTo: self, align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12),sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createProposalLabel() -> Label {
		with(.init()) {
			$0.anchorAndSize(to:issueLabel,align:.topLeft,alignTo:.bottomLeft,offset:.init(x:0,y:12),sizeOffset:.init(width:-24,height:0))
			addSubview($0)
		}
	}
	func createConfirmationContainer() -> ConfirmationContainer {
		with(.init()) {
			$0.anchorAndSize(to:self,align:bottomLeft,alignTo:bottomLeft,offset:.init(x:0,y:0),sizeOffset:.init(width:-24,height:0))
			$0.okButton.onClick = onOKButtonClick
			$0.cancelButton.onClick = onCancelButtonClick
			addSubview($0)
		}
	}
}
