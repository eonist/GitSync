import Foundation

extension Nav {
   /**
    * - Abstract: The setView is in charge of
    * ## Examples:
    * Nav.setView(.commitList) // transitions app to the commitList (aka main)
    * Nav.setView(.prefs(.repo(.repoDetail("Gitsync")))) // transitions app to repoDetail
    */
   static func setView(viewType: ViewType/*, mainView: MainView?*/) {
      Swift.print("setView: \(viewType)")
      switch viewType {
      case .dialog(_):
         Swift.print("dialog view")
         Nav.curPrompt = getView(viewType: viewType)
      case .commitList, .commitDetail(_), .prefs(_):
         Swift.print("other view")
         Nav.curView = Nav.getView(viewType: viewType)
      }
   }
}
