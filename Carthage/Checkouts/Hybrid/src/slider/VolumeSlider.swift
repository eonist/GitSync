import Foundation
#if os(iOS)
import With
import Spatial
#elseif os(macOS)
import With_mac
import Spatial_macOS
#endif

public class VolumeSlider: Slider {
   /**
    * Button
    */
   override func createThumb() -> RoundedThumb {
      return with(.init()) {
         addSubview($0)
         $0.caLayer?.backgroundColor = Color.green.cgColor
         $0.applyAnchorAndSize(to: self, width: buttonSide, height: buttonSide, align: .topLeft, alignTo: .topLeft)
         $0.onDown = onButtonDown
         $0.onMove = onButtonMove
      }
   }
   /**
    * Background
    */
   override func createBackground() -> RoundedTrack {
      return with(.init()) {
         addSubview($0)
         $0.caLayer?.backgroundColor = Color.lightGray.cgColor
         $0.anchorAndSize(to: self, align: .topLeft, alignTo: .topLeft)
         $0.onDown = onBackgroundDown
         $0.onMove = onBackgroundMove
      }
   }
}
class RoundedThumb: Thumb {
   override func drawLayout() {
      self.caLayer?.cornerRadius = self.frame.height / 2
   }
}
class RoundedTrack: Track {
   override func drawLayout() {
      guard let axis = (self.superview as? Slider)?.axis else { return }
      switch axis {
      case .hor:
         self.caLayer?.cornerRadius = self.frame.height / 4
         self.caLayer?.frame.size.height = self.frame.height / 2
         self.caLayer?.frame.origin.y = self.frame.height / 2
      case .ver:
         self.caLayer?.cornerRadius = self.frame.width / 4
         self.caLayer?.frame.size.width = self.frame.width / 2
         self.caLayer?.frame.origin.x = self.frame.width / 2
      }
   }
}
