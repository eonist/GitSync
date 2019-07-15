import Foundation

extension CommitDetailView {
   /**
    * Back
    */
   func onBackButtonClick() {
      Swift.print("onBackButtonClick")
      Nav.setView(viewType: .commitList)
   }
}
