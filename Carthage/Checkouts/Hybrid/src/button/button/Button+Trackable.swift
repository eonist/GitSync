#if os(macOS)
import Cocoa

/**
 * Code related to Trackable
 */
extension Button: MouseTrackable {
   /**
    * Fires when the mouse enters the tracking area, regardless if it is overlapping with other trackingAreas of other views
    * - Note: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
    */
   override open func mouseEntered(with event: NSEvent) {
      let viewUnderMouse: NSView? = window?.contentView?.hitTest(event.locationInWindow)
      if hasMouseEntered == false && viewUnderMouse === self {
         onOver()
         hasMouseEntered = true
      }
      super.mouseEntered(with: event)
   }
   /**
    * Fires when the mouse exits the tracking area, regardless if it is overlapping with other trackingAreas of other views
    * - Note: if you override this method in subclasses, then also call the the super of this method to avoid loss of functionality
    */
   override open func mouseExited(with event: NSEvent) {
      if hasMouseEntered {
         hasMouseEntered = false
         onOut()
      }
      super.mouseEntered(with: event)
   }
   /**
    * MouseMoved
    * - Note: mouseMoved doesn't work if the leftmouse button is pressed, then mouseDragged is used instead
    */
   override open func mouseMoved(with event: NSEvent) {
      super.mouseMoved(with: event)
      let viewUnderMouse: NSView? = window?.contentView?.hitTest(event.locationInWindow)
      if hasMouseEntered == false && viewUnderMouse === self {
         onOver()
         hasMouseEntered = true
      }
      else if hasMouseEntered && viewUnderMouse !== self {
         onOut()
         hasMouseEntered = false
      }
   }
   /**
    * This is the last NSView so we dont forward the hitTest to further descendants, however we could forward the hit test one more step to the CALayer
    * - Fixme: ⚠️️ the logic inside this method should be in the Shape, and this method should just forward to the shape, if there is a shape
    */
   override open func hitTest(_ point: NSPoint) -> NSView? {
      guard let mousePos = self.window?.mouseLocationOutsideOfEventStream else { return nil }/*you have to convert the point to localspace, this is the only reliable way to get correct mouseP from mouseDown and mouseMove*/
      let localMousePos = self.convert(mousePos, from: nil)/*We have to convert the point to localspace*/
      if self.style.isRounded, let path = path {
         let contains: Bool = path.contains(localMousePos)
         return contains ? self : nil/*return nil will tell the parent that there was no hit on this view*/
      }
      return super.hitTest(point)
   }
   var path: CGPath? {
      let r: CGFloat = self.frame.height / 2
//      Swift.print("self.frame:  \(self.frame)")
//      Swift.print(" self.bounds:  \( self.bounds)")
      let roundedRectPath: CGPath = .init(roundedRect: self.bounds, cornerWidth: r, cornerHeight: r, transform: nil)
      return roundedRectPath//CGPath.init(rect: bounds, transform: nil)
   }
   /**
    * - Abstract: the only way to update trackingArea is to remove it and add a new one
    * - Note: we could keep the trackingArea in lower level shapes/graphics so it's always easy to access, but i don't think it needs to be easily accesible atm.
    * - Parameter owner: is the instance that receives the interaction event
    * - Fixme: ⚠️️ should probably not have .mouseMoved here, but rather only add it for `onOut` events
    */
   override open func updateTrackingAreas() {
      //Swift.print("updateTrackingAreas")
      createTrackingArea([.activeAlways, .mouseMoved, .mouseEnteredAndExited])
      super.updateTrackingAreas()
   }
   /**
    * When the mouse enters the tracking area or tracking shape (Overridable)
    */
   @objc open func onOver() {
//      Swift.print("onOver")
      overCallBack()
   }
   /**
    * When the mouse exits the tracking area or tracking shape (Overridable)
    */
   @objc open func onOut() {
//      Swift.print("onOut")
      outCallBack()
   }
}
#endif
