import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif
/**
 * Create
 */
extension Slider {
   /**
    * Button
    */
   @objc func createThumb() -> Thumb {
      return with(.init()) {
         addSubview($0)
         $0.caLayer?.backgroundColor = Color.black.cgColor
         $0.applyAnchorAndSize(to: self, width: buttonSide, height: buttonSide, align: .topLeft, alignTo: .topLeft )
         $0.onDown = onButtonDown
         $0.onMove = onButtonMove
      }
   }
   /**
    * Background
    */
   @objc func createBackground() -> Track {
      return with(.init()) {
         addSubview($0)
         $0.caLayer?.backgroundColor = Color.gray.cgColor
         $0.anchorAndSize(to: self, align: .topLeft, alignTo: .topLeft )
         $0.onDown = onBackgroundDown
         $0.onMove = onBackgroundMove
      }
   }
}
