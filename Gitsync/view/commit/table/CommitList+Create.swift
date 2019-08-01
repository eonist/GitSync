import Cocoa
import With_mac

extension CommitList {
   /**
    * Table
    */
   func createTable() -> NSTableView {
      return with(.init(frame: .zero)){
         registerCells()/* Registers Cell types */
         $0.dataSource = self
         $0.delegate = self
         $0.backgroundColor = .green
         //self.rowSizeStyle = .large // ?
         //self.backgroundColor = .clear // ?
         $0.headerView = nil // ?
         let col1: NSTableColumn = .init(identifier: .init("col1"))
         //col1.width = frame.width
         //col1.width = 400//frame.width
         $0.addTableColumn(col1) // generally you want to add at least one column to the table view.
         self.documentView = $0
         //NSView(frame:.init(origin: .zero, size: .init(width: 400, height: 800)))
//         self.documentView?.addSubview($0)
      }
   }
}
