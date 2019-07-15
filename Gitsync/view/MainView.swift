import Cocoa

open class MainView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
//   var curSubView: NSView?

   override public init(frame: CGRect) {
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
   }
   /**
    * Boilerplate
    */
   required public init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
