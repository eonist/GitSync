import Cocoa
import Hybrid_macOS
import Spatial_macOS
import With_mac
/**
 * Simple way to add Ok and cancel buttons
 */
class ConfirmationContainer: NSView {
   lazy var okBUtton: Button = createOkButton()
   lazy var cancelButton: Button = createCancelButton()
   override public init(frame: CGRect) {
      Swift.print("RepoDetailView")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = okButton
      _ = cancelButton
   }
   override open var isFlipped: Bool { return true } /* TopLeft orientation */
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension ConfirmationContainer {
   /**
    * Create button
    */
   func createOkButton() -> Button {
      return with(.init()) {
         $0.anchorAndSize(to:self,align:.topLeft,alignTo:.bottomLeft, sizeMultiplier:.init(width:0.5,height:1),sizeOffset:.init(width:-12,height:0), offset:.init(x:0,y:12))
         addSubview($0)
      }
   }
   /**
    * Create button
    */
   func createCancelButton() -> Button {
      return with(.init()) {
         $0.anchorAndSize(to:self,align:.topRight,alignTo:.topRight, sizeMultiplier:.init(width:0.5,height:1),sizeOffset:.init(width:-12,height:0), offset:.init(x:0,y:12))
         addSubview($0)
      }
   }
}
