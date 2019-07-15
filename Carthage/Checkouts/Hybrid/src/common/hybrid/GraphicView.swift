import Foundation

open class GraphicView: HybridView {
   /*Constraints*/
   public var anchor: (x: NSLayoutConstraint, y: NSLayoutConstraint)?
   public var size: (w: NSLayoutConstraint, h: NSLayoutConstraint)?
}

extension GraphicView {
   /**
    * - Note: We have to store the constraints because we animate them
    * - Note: This is the only place to get frame.height consistently (when you use either AutoLayout or CGRect based layout)
    */
   #if os(iOS)
   override open func layoutSubviews() {
      super.layoutSubviews()
      drawLayout()
   }
   #elseif os(macOS)
   override open func layout() {
      super.layout()
      drawLayout()
   }
   #endif
   /**
    * Draw layout (Mutal layout call for iOS and macOS)
    */
   @objc open func drawLayout() {
      /*override in subclass*/
   }
}
