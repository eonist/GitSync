#if os(iOS)
import UIKit
public typealias View = UIView
public typealias Color = UIColor
public typealias Font = UIFont
public typealias Touch = UITouch
public typealias Label = UILabel
public typealias HybridView = UIView
public typealias BezierPath = UIBezierPath
public typealias Screen = UIScreen
#elseif os(macOS)
import Cocoa
public typealias View = NSView/*View is NOT layered-backed for macOS*/
public typealias Color = NSColor
public typealias Font = NSFont
public typealias Touch = NSTouch
public typealias Label = NSLabel
public typealias HybridView = LayerView/*HybridView is layered-backed*/
public typealias BezierPath = NSBezierPath
public typealias Screen = NSScreen
#endif

extension View {
   /**
    * Cross-platform support for layer
    */
   open var caLayer: CALayer? {
      #if os(iOS)
      return Optional(self.layer)
      #elseif os(macOS)
      return self.layer
      #endif
   }
}

extension HybridView {
   #if os(macOS)
   /**
    * - Purpouse: So we can use .backGroundColor for iOS and macOS
    */
   public var backgroundColor: Color {
      get {
         guard let caLayer = caLayer, let cgColor = caLayer.backgroundColor else { return .clear }
         return Color(cgColor: cgColor) ?? .clear
      } set {
         self.caLayer?.backgroundColor = newValue.cgColor
      }
   }
   #endif
   /**
    * - Purpouse: .borderColor for iOS and macOS
    */
   public var borderColor: Color {
      get {
         guard let caLayer = caLayer, let cgColor = caLayer.borderColor else { return .clear }
         #if os(iOS)
         return .init(cgColor: cgColor )
         #elseif os(macOS)
         return  Color(cgColor: cgColor ) ?? .clear
         #endif
      } set {
         self.caLayer?.borderColor = newValue.cgColor
      }
   }
}

extension Screen {
   /**
    * Aids in setting the correct retina resolution for graphics
    */
   public static var mainScreenScale: CGFloat {
      #if os(macOS)
      if let mainScreen = NSScreen.main {
        return mainScreen.backingScaleFactor
      }
      #elseif os(iOS)
      return UIScreen.main.scale
      #endif
      fatalError("os not supported")
   }
}
