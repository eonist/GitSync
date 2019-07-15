#if os(macOS)
import Cocoa
/**
 * Note: - use self.textColor to set text color
 */
open class NSLabel: NSTextField {
   override init(frame frameRect: NSRect) {
      super.init(frame: frameRect)
      self.isBezeled = false
      self.drawsBackground = false
      self.isEditable = false
      self.isSelectable = false
   }
   /**
    * Boilerplate
    */
   public required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   //   open override var cell: NSCell? {get{Swift.print("cell");return super.cell}set{super.cell = newValue}}
   //   open override func drawCell(_ cell: NSCell) {
   //      Swift.print("drawCell")
   //      super.drawCell(cell)
   //   }
}
#endif
