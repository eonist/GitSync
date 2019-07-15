#if os(macOS)
import Cocoa

/**
 * Core
 */
extension NSLabel {
   open var textAlignment: NSTextAlignment { get { return self.alignment } set { self.alignment = newValue } }
   open var text: String { get { return self.stringValue } set { self.stringValue = newValue } }
   override open func hitTest(_ point: NSPoint) -> NSView? {
      return isEnabled ?  super.hitTest(point) : nil
   }
   /**
    * Fixme: ⚠️️ This is not optimal, there could be a better way to do this, maybe look into: baselineOffset attributed string etc
    */
   public func centerVertically() {
      //Swift.print("self.font:  \(self.font)")
      let textHeight = self.attributedStringValue.size().height
      let font = self.font
      let isBordered = self.isBordered
      let textAlignment = self.textAlignment
      let textColor = self.textColor
      let isEnabled = self.isEnabled
      self.cell = VerticallyAlignedTextFieldCell(textHeight: textHeight, textCell: self.text)
      //Swift.print("self.font:  \(self.font)")
      self.font = font//⚠️️ we have to re-apply these after cell is set
      self.isBordered = isBordered
      self.textColor = textColor
      self.isEnabled = isEnabled
      self.textAlignment = textAlignment
   }
}
#endif

//⚠️️ it could be more resonable to add nstextfield to an nsview and use the bellow

//      #if os(macOS)/*Start - vertically center, applies only for macOS*/
//      let textHeight = label.attributedStringValue.size().height
//      let y:CGFloat = (frame.size.height / 2)  - (textHeight / 2)
//      label.frame.origin.y = y
//      #endif/*End*/
