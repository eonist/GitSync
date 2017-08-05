import Foundation

extension Nav{
    enum ViewType{
        enum Main:String{
            case commit = "commit"
            case repo = "repo"
            case prefs = "prefs"
        }
        case main(Main)
        case commitDetail([String:String])
        case repoDetail([Int])
        case dialog(Dialog)
        enum Dialog{
            case conflict
            case commit
        }
    }
}
