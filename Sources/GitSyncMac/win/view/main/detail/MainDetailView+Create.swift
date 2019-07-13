/**
 * Create
 */
extension MainDetailView {
	/**
	 * BackButton
	 */
	func createBackButton() -> BackButton {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, size: .init(width: 96, height: 32), offset: .init(x:6,y:8))
			$0.setText("Back")
			$0.onClick = onBackButtonClick
			addSubview($0)
		}
	}
	/**
    * RepoNameLabel
    */
	func createRepoNameLabel() -> NSLabel {
	    return with(.init()) {
			  $0.anchorAndSize(to: self, sizeTo: self, align: topLeft, alignTo: .topLeft, height: 24, offset: .init(12+48,2) ))
		 }
	}
	/**
    * TitleLabel
    */
	func createTitleLabel() -> NSLabel {
		return with(.init()) {
			 $0.anchorAndSize(to: repoNameLabel, sizeTo: self, align: topLeft, alignTo: .bottomLeft, height: 32, offset: .init(12,2))
			 addSubview($0)
		}
	}
	/**
    * DescriptionLabel
    */
	func createDescriptionLabel() -> NSLabel {
		return with(.init()) {
			$0.anchorAndSize(to: titleLabel, sizeTo: self, align: topLeft, alignTo: .bottomLeft,  offset: .init(12,2), sizeOffset:.init(width:0,height:-24-32-48))
			addSubview($0)
	   }
	}
}
