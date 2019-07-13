class RepoView {
	lazy var backButton : BackButton  = createBackButton()
	lazy var addRepoButton: AddRepoButton = createAddRepoButton()
	lazy var refreshIndicator: RefreshIndicator = createRefreshIndicator()
	lazy var repoList: RepoList = createRepoList()
	init() {
		_ = backButton
		_ = addRepoButton
		_ = refreshIndicator
		_ = repoList
	}
}
/**
 * Create
 */
extension RepoView {
	/**
    * BackButton
    */
	func createBackButton() -> BackButton {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, size: .init(width: 96, height: 32), offset: .init(x:6,y:8))
			$0.setText("Back")
			addSubview($0)
		}
	}
	/**
    * AddRepoButton
    */
	func createAddRepoButton() -> AddRepoButton {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, size: .init(width: 96, height: 32), offset: .init(x:6,y:8))
			$0.setText("Add repo")
			addSubview($0)
		}
	}
	/**
    * RefreshIndicator
    */
	func createRefreshIndicator() -> RefreshIndicator {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topCenter, alignTo: topCenter, size: .init(width: 44, height: 44))
			addSubview($0)
		}
	}
	/**
    * RepoList
    */
	func createRepoList() -> RepoList {
		return with(.init()) {
			$0.anchorAndSize(to: self, align:.topLeft, alignTo: topLeft, sizeOffset: .init(width: 0, height: -44), offset: .init(x:0,y:44))
			addSubview($0)
		}
	}
}
/**
 * Event
 */
 extension RepoView {
	 func onBackButtonClick() {
		  Nav.setState(.prefs)
	 }
 }
