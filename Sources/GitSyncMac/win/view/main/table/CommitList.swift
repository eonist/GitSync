class CommitList: NSTableView {
	var dataProvider: CommitDataProvider
	init(dataProvider: CommitDataProvider) {
		self.dataProvider = dataProvider
	}
}
/**
 * Cell
 */
extension CommitList {
	func reuseCell(idx: Int) {
		self.dataProvider.getItem(at: idx)
	}
	// func onReuseSection(idx: Int) {
		//get section data based on date. So Each day / week / month / year gets a section
	// }
}
/**
 * Set this up as the section / row model you have in legacy project
 */
class CommitDataProvider: DataProvider {
	var path: String
	init(path: String) {
		self.path = path
	}
}
