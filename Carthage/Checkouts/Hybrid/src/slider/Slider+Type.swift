import Foundation

extension Slider {
   public enum Axis {
      case hor, ver
   }
   public typealias OnChange = (_ progress: CGFloat) -> Void
}
/**
 * Util
 */
extension CGSize {
   /**
    * EXAMPLE: CGSize(width:100,height:200)[.hor]//100
    */
   subscript(axis: Slider.Axis) -> CGFloat {/*Convenience*/
      get {
         switch axis {
         case .hor:
            return self.width
         case .ver:
            return self.height
         }
      }set {
         switch axis {
         case .hor:
            self.width = newValue
         case .ver:
            self.height = newValue
         }
      }
   }
}
extension CGPoint {
   /**
    * EXAMPLE: CGPoint(x:20,y:30)[.hor]//20
    */
   subscript(dir: Slider.Axis) -> CGFloat {/*Convenience*/
      get {
         switch dir {
         case .hor:
            return self.x
         case .ver:
            return self.y
         }
      }set {
         switch dir {
         case .hor:
            self.x = newValue
         case .ver:
            self.y = newValue
         }
      }
   }
}
