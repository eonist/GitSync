import Foundation
@testable import Utils

extension Nav{
    enum ViewType {
        /*Main*/
        enum Main: String{
         case commit, repo, prefs, stats
        }
        case main(Main)
        /*Detail*/
        enum Detail{
            case commit([String: String])
            case repo([Int])
        }
        case detail(Detail)
        /*Dialog*/
        case dialog(Dialog)
        enum Dialog{
            case conflict(MergeConflict)
            case commit(RepoItem, CommitMessage, CommitDialogView.Completed)
            case autoInit(AutoInitConflict, AutoInitView.Complete)
        }
    }
}
