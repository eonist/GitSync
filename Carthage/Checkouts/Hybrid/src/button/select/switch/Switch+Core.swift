import Foundation
#if os(iOS)
import Spatial
#elseif os(macOS)
import Spatial_macOS
#endif

extension Switch {
   /**
    * Change foreground
    */
   func toggleForegroundPosition() {
//      Swift.print("toggleForeground")
      let alignment: Alignment = selected ? .topRight : .topLeft
      let offset: CGPoint = selected ? .init(x: -4, y: 4) : .init(x: 4, y: 4)
//      Swift.print("alignment:  \(alignment)")
      if let anchor = foreground.anchor { NSLayoutConstraint.deactivate([anchor.x, anchor.y]) }
      foreground.applyAnchor(to: self, align: alignment, alignTo: alignment, offset: offset)
   }
}
