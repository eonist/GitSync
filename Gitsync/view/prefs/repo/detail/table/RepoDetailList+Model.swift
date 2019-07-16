import Foundation

/**
 * Model
 */
extension RepoDetailList {
   /**
    * Creates the data for rows (Model)
    */
   func createRows() -> [CellDataKind] {
      let nameData: TextCellData = .init(staticText: "Repo name: ", dynamicText: "Gitsync")
      let localData: TextCellData = .init(staticText: "Local path: ", dynamicText: "~/Documents/dev/Gitsync/")
      let remoteData: TextCellData = .init(staticText: "Remote path: ", dynamicText: "https://github.com/gitsync/Gitsync")
      //Fixme: ⚠️️ Use ComboBoxInputData in the future: .init(title: "Branch", selections: ["Master","Dev"])
      let branchData: TextCellData = .init(staticText: "Branch: ", dynamicText: "master")
      let isActiveData: OptionCellData = .init(staticText: "Active:", isSelected: true)
      let useMessageData: OptionCellData = .init(staticText: "Message", isSelected: true)
      let useAutomationData: OptionCellData = .init(staticText: "Auto", isSelected: true)
      return [nameData, localData, remoteData, branchData, isActiveData, useMessageData, useAutomationData]
   }
}
