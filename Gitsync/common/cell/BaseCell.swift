import Cocoa

class BaseCell: NSTableCellView {
   var data: CellDataKind? // Stores cellData
   /**
    * Init
    */
   override init(frame frameRect: NSRect = .zero) {
      super.init(frame: frameRect)
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
