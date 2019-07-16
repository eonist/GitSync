import Foundation
/**
 * Model
 */
extension PrefsList {
   /**
    * Creates the data for rows (Model)
    */
   func createRows() -> [CellDataKind] {
      let repoListData: StaticTextCellData = .init(staticText: "Repo list")
      let githubLoginData: TextCellData = .init(staticText: "Github login:", dynamicText: "eonist")
      let githubPasswordData: TextCellData = .init(staticText: "Github password:", dynamicText: "425fsd334fsdcsfw34")
      let defaultPathData: TextCellData = .init(staticText: "Default path", dynamicText: "~/Documents/dev/")
      let darkModeData: OptionCellData = .init(staticText: "Dark mode:", isSelected: false)
      return [repoListData, githubLoginData, githubPasswordData,defaultPathData,darkModeData]
      
   }
}
