import Foundation
#if os(iOS)
/**
 * Interaction
 */
extension AnimationButton {
   /**
    * down
    */
   override open func onDown() {
      super.onDown()
      self.shrink {
         self.textLabel.alpha = 0.2
      }
   }
   /**
    * up
    */
   override open func onUp() {
      super.onUp()
      self.grow {
         self.textLabel.alpha = 1.0
      }
   }
}

#endif
