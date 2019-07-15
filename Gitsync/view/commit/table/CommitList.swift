import Cocoa
import With_mac

class CommitList: NSScrollView{
   let rowData: [String]
//   lazy var scrollView : NSScrollView = createScrollView()
   lazy var table: NSTableView = createTable()
   /**
    * ## Example:
    * .init(rowData: ["John", "Douglas", "Alba", "Albert", "Ben", "Laura"])
    */
   init(rowData: [String], frame: CGRect = .zero){
      self.rowData = rowData
      super.init(frame: frame)
//      $0.translatesAutoresizingMaskIntoConstraints = false
      self.autohidesScrollers = true
      self.borderType = .noBorder
      self.hasHorizontalScroller = false
      self.hasVerticalScroller = true
      
      
      table.reloadData() // might be not needed?
      table.selectionHighlightStyle = .none
   }
   /**
    * Boilerplate
    */
   required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
