import Cocoa

extension RepoList: NSTableViewDelegate {
   /**
    * Row-height
    */
   func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
      return 42
   }
   /**
    * Cell for row-idx
    * Fixme: ⚠️️ implement cell reuse from: https://gist.github.com/peteog/37c3951a13ee2c4f9031b1df0d46f99c
    * Fixme: add ReusableCell framework
    */
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      guard (tableColumn?.identifier)!.rawValue == "col1" else { fatalError("column identifier not found") }
      let data: CellDataKind = rowData[row]
      let cell: RepoListCell = .init() // Create a cell
      cell.identifier = NSUserInterfaceItemIdentifier(rawValue: "repoListCell")
      cell.data = data
      return cell
   }
}

/**
 * DataSource delegate
 */
extension RepoList: NSTableViewDataSource {
   /**
    * Num of rows
    */
   func numberOfRows(in tableView: NSTableView) -> Int {
      return rowData.count
   }
}
