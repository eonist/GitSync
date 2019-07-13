/**
 * Event
 */
extension RepoList {
	func onCellClick(idx: Int){
		//go to detail
		Nav.setState(.prefs(.repo(.repoDetail(idx))))
	}
}
