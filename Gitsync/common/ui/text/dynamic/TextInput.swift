import Cocoa
import Hybrid_macOS
/**
 * TextInput
 */
class TextInput: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var descriptionLabel: NSLabel = createDescriptionLabel()
   lazy var contentTextField: NSTextField = createContentTextField()
   override public init(frame: CGRect) {
      Swift.print("PrefsView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
//      self.layer?.backgroundColor = NSColor.clear.cgColor
     
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

