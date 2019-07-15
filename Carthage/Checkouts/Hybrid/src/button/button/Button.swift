#if os(iOS)
import Spatial
#elseif os(macOS)
import Spatial_macOS
#endif
import Foundation
/**
 * ## Examples:
 * let btn:Button = .init(frame: .init(x:0,y:0,width:120,height:40))
 * view.addSubview(btn)
 * btn.tapUpInsideCallBack = { Swift.print("🎉") }
 * - Fixme: ⚠️️ Style could be StyleKind and then be overriden in subclasses?
 * - Note: ConstraintKind: Makes the component work with bulk autolayout functionality and animation
 */
open class Button: GraphicView, ConstraintKind {/*We use HybridView because that is layerbacked in macOS*/
   internal var hasMouseEntered: Bool = false/*Required for onOver / onOut to work*/
   /*Call-backs*/
   public var upInsideCallBack: UpInsideCallBack = defaultUpInside//rename to upInside
   public var upOutsideCallBack: UpOutsideCallBack = defaultUpOutside//upOutside
   public var downCallBack: DownCallBack = defaultDown//down
   public var upCallBack: UpCallBack = defaultUp//up
   #if os(macOS)
   public var overCallBack: UpCallBack = defaultOver//over
   public var outCallBack: UpCallBack = defaultOut//out
   #endif
   /*Style*/
   internal var style: Style
   /**
    * Initiate
    * setting raster ref: https://stackoverflow.com/questions/24316705/how-to-draw-a-smooth-circle-with-cashapelayer-and-uibezierpath
    */
   public init(style: Style = Button.defaultStyle, frame: CGRect = .zero) {
      self.style = style
      super.init(frame: frame)
      self.caLayer?.rasterizationScale = 2.0 * Screen.mainScreenScale
      self.caLayer?.shouldRasterize = true
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
