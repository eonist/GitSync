class RepoList: NSTableView {
	init(){
		self.style = .bare //remove styling
		self.registerCell([RepoListCell.self]) //register RepoListCell
	}
}
