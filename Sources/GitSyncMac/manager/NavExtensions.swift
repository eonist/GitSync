import Foundation
@testable import Utils  

extension Nav{
    enum ViewType{
        /*Main*/
        enum Main:String{
            case commit = "commit"
            case repo = "repo"
            case prefs = "prefs"
        }
        case main(Main)
        /*Detail*/
        enum Detail{
            case commit([String:String])
            case repo([Int])
        }
        case detail(Detail)
        /*Dialog*/
        case dialog(Dialog)
        enum Dialog{
            case conflict(MergeConflict)
            case commit(RepoItem,CommitMessage)
        }
    }
}
