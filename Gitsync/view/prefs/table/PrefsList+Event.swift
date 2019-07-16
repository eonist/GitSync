import Cocoa

extension PrefsList {
   /**
    * This is called when the user clicks a row
    */
   func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
      Swift.print("row:  \(row)")
      if row == 0 {
         Nav.setView(viewType: .prefs(.repo(.repoList)))
         return true
      } else { // other items are not selectable
         return false
      }
   }
}
