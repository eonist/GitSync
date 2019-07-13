/**
 * Create
 */
extension MainView {
	func createCommitList() -> CommitList {
		let dataProvider: CommitDataProvider = .init(path: "commitList.json")
	   var list = CommitList()
		list.anchorAndSize(to: self, sizeTo: self)
		return list
	}
	func createPrefsButton() -> PrefsButton {
	    let prefsButton: PrefsButton = .init()
		 prefsButton.anchorAndSize($0, to: self, size: .init(width: 48, height: 48), align: .rightBottom, alignTo: .rightBottom, offset: .init(x: -24, y: -24))
		 prefsButton.onClick = onPrefsClick
		 return prefsButton
	}
}
