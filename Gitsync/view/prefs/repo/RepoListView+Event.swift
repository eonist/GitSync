import Foundation

extension RepoListView {
   /**
    * Back
    */
   func onBackButtonClick() {
      Swift.print("onBackButtonClick")
      Nav.setView(viewType: .prefs(.prefsList))
   }
   func onAddButtonClick() {
      Swift.print("onAddButtonClick")
   }
}
