import Foundation
/**
 * Core
 */
extension SelectButton {
   /**
    * Fixme: ⚠️️ This is not needed as you can set it in style
    */
   override open func drawLayout() {
      self.caLayer?.cornerRadius = self.frame.height / 2
   }
}
