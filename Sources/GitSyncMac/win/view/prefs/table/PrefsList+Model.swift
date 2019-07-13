/**
 * Model
 */
extension PrefsList {
	/**
    * Creates the data for rows (Model)
    */
	func createRows() -> [CellDataKind] {
		let githubLoginData: TextInputData = .init(title: "Github login:", inputText: "eonist")
		let githubPasswordData: TextInputData = .init(title: "Github password:", inputText: "425fsd334fsdcsfw34")
		let defaultPathData: TextInputData = .init(title: "Default path", inputText: "~/Documents/dev/")
		let darkModeData: CheckBoxInputData = .init(title: "Dark mode:", isSelected: false)
		return [githubLoginData, githubPasswordData, defaultPathData, darkModeData]
	}
}
