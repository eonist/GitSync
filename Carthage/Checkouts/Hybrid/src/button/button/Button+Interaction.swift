#if os(iOS)
import UIKit
/**
 * Override default behaviours
 */
extension Button {
   /**
    * On tap down inside
    */
   override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      if let touch = touches.first, touch.view == self {/*touch began*/
         onDown()
      }
      super.touchesBegan(touches, with: event)
   }
   /**
    * On tap up inside
    */
   override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      if let touch = touches.first {/*Touch ended*/
         if touch.view == self {
            let touchPointInButton = touch.location(in: self)
            self.bounds.contains(touchPointInButton) ? onUpInside() : onUpOutside()
         }
         onUp()/*not sure if this should fire before or after the inside and outside calls*/
      }
   }
   /**
    * NOTE: In a tableview, this is fired if the tap starts to drag the tableview etc
    */
   override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesCancelled(touches, with: event)
      if touches.first != nil {/*Touch ended*/
         onUp()
      }
   }
}
#elseif os(macOS)
import Cocoa

extension Button {
   /**
    * Mouse down
    */
   override open func mouseDown(with event: NSEvent) {
//      Swift.print("mouseDown")
      onDown()
   }
   /**
    * Mouse up
    * - Important ⚠️️ Remember to set .isEnabled = false for views that may cover and claim viewUnderMouse, then upInside wont work
    */
   override open func mouseUp(with event: NSEvent) {
//      Swift.print("mouseUp")
      let viewUnderMouse: NSView? = window?.contentView?.hitTest(event.locationInWindow)
      viewUnderMouse === self ? onUpInside() : onUpOutside()/*if the event was on this button call triggerRelease, else triggerReleaseOutside*/
      onUp()
   }
}
#endif
/**
 * Interactions (Common for iOS and macOS)
 */
extension Button {
   /**
    * Overridable
    */
   @objc open func onUp() {
//      Swift.print("onUp")
      upCallBack()
   }
   /**
    * Overridable
    */
   @objc open func onUpInside() {
      upInsideCallBack()
   }
   /**
    * Overridable
    */
   @objc open func onUpOutside() {
      upOutsideCallBack()
   }
   /**
    * Overridable
    */
   @objc open func onDown() {
//      Swift.print("onDown")
      downCallBack()
   }
}
