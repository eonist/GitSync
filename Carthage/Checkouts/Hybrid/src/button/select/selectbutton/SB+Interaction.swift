import Foundation
/**
 * Interaction
 */
extension SelectButton {
   /**
    * onTapUpInside
    */
   override open func onUpInside() {
      Swift.print("onUpInside")
      super.onUpInside()
      selected.toggle()
   }
}
