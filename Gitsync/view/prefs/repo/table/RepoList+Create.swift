import Cocoa
import With_mac

extension RepoList {
   /**
    * Table
    */
   func createTable() -> NSTableView {
      Swift.print("RepoList.createTable")
      return with(.init(frame: self.frame)){
//         registerCells()/* Registers Cell types */
         $0.dataSource = self
         $0.delegate = self
         $0.backgroundColor = .clear
         //      self.rowSizeStyle = .large // ?
         //      self.backgroundColor = .clear // ?
         $0.headerView = nil // ?
         let col1: NSTableColumn = .init(identifier: .init("col1"))
         //      col1.width = frame.width
         //         col1.width = 400//frame.width
         $0.addTableColumn(col1) // generally you want to add at least one column to the table view.
         self.documentView = $0
         //         scrollView.addSubview($0)
      }
   }
}
