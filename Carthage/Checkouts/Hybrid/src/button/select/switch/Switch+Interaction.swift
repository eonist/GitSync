import Foundation
/**
 * Interaction
 */
extension Switch {
   /**
    * onTapUpInside
    */
   override open func onUpInside() {
//      Swift.print("onUpInside")
      super.onUpInside()
      selected.toggle()
   }
}
