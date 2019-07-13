class RepoListCell: NSTableViewCell {
	lazy var repoNameLabel: RepoNameLabel = createRepoNameLabel
	var data: RepoListCellData {
	 	didSet {
			repoNameLabel.setText(data.repoName)
		}
	}
}
/**
 * Create
 */
extension RepoListCell {
	/**
    * RepoNameLabel
    */
   func createRepoNameLabel() -> NSLabel {
	  	with(.init()){
			$0.anchorAndSize(to:self, align:centerLeft,alignTo: centerLeft,height: 32)
			$0.fontSize = 24
			addSubview($0)
		}
   }
}
struct RepoListCellData: CellDataKind {
	let repoName: String
}
