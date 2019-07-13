/**
 * Model
 */
extension RepoDetailList {
	/**
    * Creates the data for rows (Model)
    */
	func createRows() -> [CellDataKind] {
		let nameData: TextInputData = .init(title: "Repo name", inputText: "Gitsync")
		let localData: TextInputData = .init(title: "Local path", inputText: "~/Documents/dev/Gitsync/")
		let remoteData: TextInputData = .init(title: "Remote path", inputText: "https://github.com/gitsync/Gitsync")
		let branchData: ComboBoxInputData = .init(title: "Branch", selections: ["Master","Dev"])
		let isActiveData: CheckBoxInputData = .init(title: "Active:", isSelected: true)
		let useMessageData: CheckBoxInputData = .init(title: "Message", isSelected: true)
		let useAutomationData: CheckBoxInputData = .init(title: "Auto", isSelected: true)
		return [nameData, localData, remoteData, branchData, isActiveData, useMessageData, useAutomationData]
	}
}
