class CommitList: NSTableView {
	var dataProvider: CommitDataProvider
	init(dataProvider: CommitDataProvider) {
		self.dataProvider = dataProvider
	}
}
