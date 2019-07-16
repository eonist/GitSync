import Cocoa

extension RepoList {
   /**
    * This is called when the user clicks a row
    */
   func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
      Swift.print("row:  \(row)")
      Nav.setView(viewType: .prefs(.repo(.repoDetail(repoName: "\(row)"))))
      return true
   }
}
