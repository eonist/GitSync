import Cocoa

extension CommitList: NSTableViewDelegate {
   /**
    * Row-height
    */
   func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
      return 48
   }
   /**
    * Cell for row-idx
    */
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      guard (tableColumn?.identifier)!.rawValue == "col1" else { fatalError("column identifier not found") }
      let str = rowData[row]
      let view = NSTextField(string: str)
      view.textColor = .black
      view.isEditable = false
      view.isBordered = false
      view.backgroundColor = .clear
      return view
   }
   /**
    * Num of rows
    */
   func numberOfRows(in tableView: NSTableView) -> Int {
      return rowData.count
   }
   /**
    * Maybe this makes things selectable?
    */
   func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
      return true
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

//https://stackoverflow.com/a/54754584/5389500

// Create a cell
//let newCell = NSTableCellView()
//newCell.identifier = "CodeCreatedTableCellView"
//newCell.addSubview(textField)
//newCell.textField = textField


//class MyTableCellView: NSTableCellView {
//   
//   var aTextField: NSTextField?
//   
//   override init(frame frameRect: NSRect) {
//      super.init(frame: frameRect)
//      aTextField = NSTextField(frame: frameRect)
//      aTextField?.drawsBackground = false
//      aTextField?.bordered = false
//      self.addSubview(aTextField!)
//   }
//   
//   required init?(coder: NSCoder) {
//      fatalError("init(coder:) has not been implemented")
//   }
//   
//}
