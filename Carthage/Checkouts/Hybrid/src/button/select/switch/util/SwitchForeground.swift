import Foundation
#if os(iOS)
import Spatial
#elseif os(macOS)
import Spatial_macOS
#endif

public class SwitchForeground: GraphicView, ConstraintKind {
   init(backgroundColor: Color, frame: CGRect) {
      super.init(frame: frame)
      self.caLayer?.backgroundColor = backgroundColor.cgColor
      self.caLayer?.rasterizationScale = 2.0 * Screen.mainScreenScale
      self.caLayer?.shouldRasterize = true
      #if os(iOS)
      self.isUserInteractionEnabled = false//⚠️️ iOS might support hitTest as well
      #endif
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
extension SwitchForeground {
   override public func drawLayout() {
//      Swift.print("self.caLayer?.frame.size:  \(self.caLayer?.frame.size)")
      self.caLayer?.cornerRadius = self.frame.size.height / 2
   }
   #if os(macOS)
   override public func hitTest(_ point: CGPoint) -> View? {
      return nil
   }
   #endif
}
