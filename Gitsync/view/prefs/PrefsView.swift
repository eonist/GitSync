import Cocoa
import Hybrid_macOS
/**
 * PrefsView
 */
open class PrefsView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var backButton: Button = createBackButton()
   lazy var prefsList: PrefsList = createPrefsList()
   
   override public init(frame: CGRect) {
      Swift.print("PrefsView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = backButton
      _ = prefsList
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
