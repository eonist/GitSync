import Foundation

extension Button {
   override open func drawLayout() {
//      Swift.print("Button.drawLayout")
      self.caLayer?.cornerRadius = self.style.isRounded ? self.frame.height / 2 : 0
      self.caLayer?.borderColor = style.borderColor.cgColor
      self.caLayer?.backgroundColor = style.backgroundColor.cgColor
      self.caLayer?.borderWidth = style.borderWidth
   }
}
