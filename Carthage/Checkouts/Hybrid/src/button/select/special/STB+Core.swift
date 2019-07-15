import Foundation
/**
 * Core
 */
extension SelectableTextButton {
   /**
    * - Note: We have to store the constraints because we animate them
    * - Note: This is the only place to get frame.height consistently (when you use either AutoLayout or CGRect based layout)
    */
   override open func drawLayout() {
      super.drawLayout()
      self.caLayer?.cornerRadius = self.frame.height / 2
   }
}
