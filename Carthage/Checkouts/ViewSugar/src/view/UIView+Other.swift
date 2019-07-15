#if os(iOS)
import UIKit.UIView
/**
 * Other
 */
extension UIView {
   /**
    * Creates UIImage from a view
    * - Important: ⚠️️ if you get the "invalid context 0x0" error, make sure your View has a frame. view.bounds must not be .zerp
    */
   public var snapShot: UIImage? {
      UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
      self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
      let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return image
   }
   /**
    * Returns rotation of view
    */
   public var rotation: CGFloat {
      let radians = atan2(self.transform.b, self.transform.a)
      let degrees = radians * 180 / .pi
      return degrees
   }
   /**
    * - Note: this method gives you the scale regardless of rotation or translation applied to transform:
    * - Reference: https://stackoverflow.com/a/46223255/5389500
    */
   public var scale: CGFloat {
      return sqrt(self.transform.a * self.transform.a + self.transform.c * self.transform.c)
   }
   /**
    * Returns color for point in UIView
    */
   public func color(point: CGPoint) -> UIColor {
      let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
      let bitmapInfo: CGBitmapInfo = .init(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)//fromRaw()!
      var pixelData: [UInt8] = [0, 0, 0, 0]
      if let context = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) {
         context.translateBy(x: -point.x, y: -point.y)
         self.layer.render(in: context)
      }
      let red: CGFloat = .init(pixelData[0]) / .init(255.0)
      let green: CGFloat = .init(pixelData[1]) / .init(255.0)
      let blue: CGFloat = .init(pixelData[2]) / .init(255.0)
      let alpha: CGFloat = .init(pixelData[3]) / .init(255.0)
      let color: UIColor = .init(red: red, green: green, blue: blue, alpha: alpha)
      return color
   }
}
#endif
