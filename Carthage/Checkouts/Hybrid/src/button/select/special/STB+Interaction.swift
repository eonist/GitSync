import Foundation
/**
 * Interaction
 */
extension SelectableTextButton {
   /**
    * onTapUpInside
    */
   override open func onUpInside() {
      Swift.print("onUpInside")
      super.onUpInside()
      selected.toggle() //toggle
   }
}
