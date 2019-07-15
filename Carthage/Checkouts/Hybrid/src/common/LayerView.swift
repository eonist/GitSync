#if os(macOS)
import Cocoa

open class LayerView: FlippedView {
   override public init(frame frameRect: NSRect) {
      super.init(frame: frameRect)
      self.wantsLayer = true/*if true then view is layer backed*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

open class FlippedView: NSView {
   override open var isFlipped: Bool { return true }
}
#endif
