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
