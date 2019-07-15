import Cocoa

extension CommitList {
   /**
    * This is called when the user clicks a row
    */
   func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
      Swift.print("row:  \(row)")
      Nav.setView(viewType: .commitDetail(title: "\(row)"))
      return true
   }
}
