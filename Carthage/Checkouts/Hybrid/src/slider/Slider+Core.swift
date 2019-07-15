import Foundation

extension Slider {
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
    * Called when autolayout changes on the entire component (Beta)
    */
   @objc open func drawLayout() {
      let progress = self.progress
      self.progress = progress
   }
}
