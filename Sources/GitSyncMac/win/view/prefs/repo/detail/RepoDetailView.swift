/**
 *
 */
class RepoDetailView: NSView {
	lazy var backButton: BackButton = createBackButton()
	lazy var repoDetailList: RepoDetailList = createRepoDetailList()
	init(){
		_ = backButton
		_ = repoDetailList
	}
}
/**
 *
 */
extension RepoDetailView {
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
	/*
    * RepoDetailList
    */
	func createRepoDetailList() -> RepoDetailList {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, sizeOffset: .init(width: 0, height: -44), offset: .init(x:0,y:44))
			addSubview($0)
		}
	}
}
/**
 * Event
 */
 extension {
	 /**
     * On backButton click
     */
	 func onBackButtonClick() {
		  Nav.setState(.prefs(.repo)
	 }
 }
