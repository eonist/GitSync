import Foundation

extension RepoDetailView {
   /**
    * Back
    */
   func onBackButtonClick() {
      Swift.print("RepoDetailView.onBackButtonClick")
      Nav.setView(viewType: .prefs(.repo(.repoList)))
   }
}
