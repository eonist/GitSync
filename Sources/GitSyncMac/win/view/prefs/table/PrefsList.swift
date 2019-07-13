class PrefsList {
	init() {
		self.style = .bare
		self.registerCell([TextInputCell.self, CheckBoxInputCell.self])
	}
}
