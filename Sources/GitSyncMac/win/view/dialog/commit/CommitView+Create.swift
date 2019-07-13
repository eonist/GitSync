/**
 * Create
 */
extension CommitView {
	func createRepoLabel() -> NSLabel {
		return with(.init()) {
			$0.anchorAndSize(to: self, height: 24, align: topLeft, alignTo:.topLeft, offset: .init(x:12, y:12), sizeOffset:.init(width:-24,height:0))
			addSubView($0)
		}
	}
	func createRepoTextField() -> NSTextField {
		return with(.init()) {
		  $0.anchorAndSize(to: self, height: 24, align: topLeft, alignTo:.topLeft, offset: .init(x:12, y:12), sizeOffset:.init(width:-24,height:0))
		  addSubView($0)
	  }
	}
	func createTitleLabel() -> NSLabel {
		return with(.init()) {
			$0.anchorAndSize(to: self, height: 24, align: topLeft, alignTo:.topLeft, offset: .init(x:12, y:12), sizeOffset:.init(width:-24,height:0))
			addSubView($0)
		}
	}
	func createTitleTextField() -> NSTextField {
		return with(.init()) {
		  $0.anchorAndSize(to: self, height: 24, align: topLeft, alignTo:.topLeft, offset: .init(x:12, y:12), sizeOffset:.init(width:-24,height:0))
		  addSubView($0)
	  }
	}
	func createDescriptionLabel() -> NSLabel {
		return with(.init()) {
			$0.anchorAndSize(to: self, height: 24, align: topLeft, alignTo:.topLeft, offset: .init(x:12, y:12), sizeOffset:.init(width:-24,height:0))
			addSubView($0)
		}
	}
	func createDescriptionTextField() -> NSTextField {
		return with(.init()) {
		  $0.activateAnchorAndSize { view in
				let tl = Constraint.anchor(view, to: descriptionLabel, align:.topLeft, alignTo: bottomLeft, offset: .init(x:0, y:12))
				let br = Constraint.anchor(view, to: descriptionLabel, align:.bottomRight, alignTo: bottomRight, offset: .init(x:-12, y:-12))
				return [tl,br]
			}
		  addSubView($0)
	  }
	}
	/**
	 * Creates createConfirmationContainer
	 */
	func createConfirmationContainer() -> ConfirmationContainer {
		 with(.init()) {
			 $0.anchorAndSize(to: descriptionTextField, sizeTo: descriptionTextField, height:32, align: .topLeft, alignTo: .bottomLeft, offset:.init(x:0,y:12))
			 $0.okButton.onClick = onOKButtonClick
			 $0.cancelButton.onClick = onCancelButtonClick
			 addSubview($0)
		 }
	}
}
