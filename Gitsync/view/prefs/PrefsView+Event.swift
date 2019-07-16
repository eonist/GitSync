import Foundation

extension PrefsView {
   /**
    * Back
    */
   func onBackButtonClick() {
      Swift.print("onBackButtonClick")
      Nav.setView(viewType: .commitList)
   }
}
