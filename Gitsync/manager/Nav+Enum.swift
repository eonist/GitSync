import Foundation

/**
 * This is the state of the app
 * - Abstract: Great for navigating and deep-linking
 * ## Examples:
 * Nav.setView(viewType: )
 */
extension Nav {
   enum ViewType { /* Main */
      case commitList
      case commitDetail(title: String)
      case prefs(Prefs)
      case dialog(Dialog)
      enum Prefs {
         case prefsList
         enum Repo {
            case repoList, repoDetail(repoName: String)
         }
         case repo(Repo)
      }
      enum Dialog { // Dialogs
         case mergeConflict(conflict: String)//MergeConflict
         case commit(repoName: String, commitMSG:String) // RepoItem, CommitMessage, CommitDialogView.Completed
         case autoInit(conflict: String)//AutoInitConflict, AutoInitView.Complete
         case error(problem: String)//AutoInitConflict, AutoInitView.Complete
      }
   }
}
