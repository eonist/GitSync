import Cocoa

extension CommitList: NSTableViewDelegate {
   /**
    * Row-height
    */
   func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
      return 120
   }
   /**
    * Cell for row-idx
    * Fixme: ⚠️️ implement cell reuse from: https://gist.github.com/peteog/37c3951a13ee2c4f9031b1df0d46f99c
    * Fixme: add ReusableCell framework
    */
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      guard (tableColumn?.identifier)!.rawValue == "col1" else { fatalError("column identifier not found") }
      let str = rowData[row]
      let newCell = CommitCell.init(frame: .zero, repoName: str) // Create a cell
      newCell.identifier = NSUserInterfaceItemIdentifier(rawValue: "commitCell")
      return newCell
   }
   /**
    * Num of rows
    */
   func numberOfRows(in tableView: NSTableView) -> Int {
      return rowData.count
   }
   /**
    * Register cells
    */
   func registerCells() {
      //      self.register(CustomCell.self, forCellReuseIdentifier: "\(CustomCell.self)")
      //      self.register(AnotherCustomCell.self, forCellReuseIdentifier: "\(AnotherCustomCell.self)")
   }

}


extension CommitList: NSTableViewDataSource { }
//   func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//      let cell = tableView.makeView(withIdentifier: .init("col1"), owner: self) as? NSTableCellView
//      let textField = cell?.textField
//      textField?.stringValue = "test"
//      return cell
//   }

//






//      var textView = tableView.makeViewWithIdentifier("textView", owner: self) as? NSTextView
//      if textView == nil {
//         textView = NSTextView()
//         textView?.identifier = "textView"
//      }

// Create a text field for the cell


// Create a cell
//      let cell = CustomTableCellView() // Doing this to see that cells get re-used
//      cell.identifier = id
//      cell.addSubview(textField)
//      cell.textField = textField
//



