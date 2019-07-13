import Foundation
/**
 * RepoDetailList
 */
class RepoDetailList {
	lazy var rows: [CellDataKind] = createRows()
	init() {
		self.style = .bare
		self.register(TextInputCell.self, ComboboxInputCell.self, CheckBoxInputCell.self)
	}
}
