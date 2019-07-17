import Cocoa
import Hybrid_macOS
import Spatial_macOS
import With_mac
/**
 * Simple way to add Ok and cancel buttons
 */
class ConfirmationContainer: NSView {
   override open var isFlipped: Bool { return true } /* TopLeft orientation */
   lazy var okButton: TextButton = createOkButton()
   lazy var cancelButton: TextButton = createCancelButton()
   override public init(frame: CGRect) {
      Swift.print("RepoDetailView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = okButton
      _ = cancelButton
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
