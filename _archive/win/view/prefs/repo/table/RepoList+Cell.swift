/**
 * Cell
 */
extension RepoList {
	func onCellReuse(idx: Int) -> NSCell {
		let cell = RepoListCell()
		cell.data = rows[idx]
		return cell
	}
}
