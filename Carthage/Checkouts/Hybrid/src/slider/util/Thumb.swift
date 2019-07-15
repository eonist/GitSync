#if os(iOS)
import Spatial
import UIKit
#elseif os(macOS)
import Spatial_macOS
import Cocoa
#endif

class Thumb: InteractiveView, ConstraintKind {
   /*Constraints*/
   #if os(iOS)
   /**
    * Thouch moved
    */
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touch = touches.first /* touch.view == self*/ {
         let touchPoint = touch.location(in: self.superview)
         onMove(touchPoint)
      }
   }
   #elseif os(macOS)
   /**
    * Mouse dragged
    */
   override func mouseDragged(with event: NSEvent) {
      let p: CGPoint = self.superview!.convert(event.locationInWindow, from: nil)
      onMove(p)
   }
   #endif
}
