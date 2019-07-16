import Foundation
/**
 * Model
 */
extension RepoList {
   /**
    * Creates the data for rows (Model)
    */
   func createRows() -> [StaticTextCellData] {
      let repoitem1: StaticTextCellData = .init(staticText: "Gitsync")
      let repoitem2: StaticTextCellData = .init(staticText: "Spatial")
      let repoitem3: StaticTextCellData = .init(staticText: "FileWatcher")
      return [repoitem1, repoitem2, repoitem3]
   }
}
