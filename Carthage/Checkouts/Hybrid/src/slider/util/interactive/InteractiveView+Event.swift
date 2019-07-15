#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * Event
 */
extension InteractiveView {
   #if os(iOS)
   /**
    * On tap down inside
    */
   override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      if  let touch: UITouch = touches.first/*, touch.view == self*/ {
         let touchPoint: CGPoint = touch.location(in: self)
         onDown(touchPoint)
      }
      super.touchesBegan(touches, with: event)
   }
   /**
    * On tap up inside
    */
   override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touch: UITouch = touches.first/*, touch.view == self*/ {
         let touchPoint: CGPoint = touch.location(in: self)
         onUp(touchPoint)
      }
      super.touchesEnded(touches, with: event)
   }
   /**
    * When touches move
    */
   override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touch: UITouch = touches.first /*, touch.view == self*/ {
         let touchPoint: CGPoint = touch.location(in: self)
         onMove(touchPoint)
      }
      super.touchesMoved(touches, with: event)
   }
   #elseif os(macOS)
   /**
    * Mouse down
    */
   override open func mouseDown(with event: NSEvent) {
      let p: CGPoint = self.convert(event.locationInWindow, from: nil)
      onDown(p)
   }
   /**
    * Mouse up
    */
   override open func mouseUp(with event: NSEvent) {
      let p: CGPoint = self.convert(event.locationInWindow, from: nil)
      onUp(p)
   }
   /**
    * Mouse dragged
    */
   override func mouseDragged(with event: NSEvent) {
      let p: CGPoint = self.convert(event.locationInWindow, from: nil)
      onMove(p)
   }
   #endif
}
