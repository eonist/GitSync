#if os(macOS)
import Cocoa

class VerticallyAlignedTextFieldCell: NSTextFieldCell {
   let textHeight: CGFloat
   init(textHeight: CGFloat, textCell string: String) {
      self.textHeight = textHeight
      super.init(textCell: string)
   }
   required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   override func drawingRect(forBounds rect: NSRect) -> NSRect {
      let newRect = NSRect(x: 0, y: (rect.size.height - textHeight) / 2, width: rect.size.width, height: rect.size.height)
      return super.drawingRect(forBounds: newRect)
   }
}
#endif
