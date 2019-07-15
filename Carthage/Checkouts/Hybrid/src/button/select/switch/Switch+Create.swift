import Foundation
#if os(iOS)
import Spatial
#elseif os(macOS)
import Spatial_macOS
#endif
/**
 * Create
 */
extension Switch {
   /**
    * SwitchForeground
    */
   func createForeground() -> SwitchForeground {
//      Swift.print("createForeground")
      let foreground: SwitchForeground = .init(backgroundColor: switchStyle.foregroundColor, frame: .zero)
      addSubview(foreground)
      foreground.activateSize { view in
         let w = Constraint.length(view, to: self, viewAxis: .hor, toAxis: .ver, offset: -8)
         let h = Constraint.length(view, to: self, viewAxis: .ver, toAxis: .ver, offset: -8)
         return (w, h)
      }
      return foreground
   }
}
//let size:CGSize = .init(width:self.frame.size.width-8, height:self.frame.size.height-8)
//self.caLayer?.position = .init(x:self.frame.origin.x+4, y:self.frame.origin.y+4)
