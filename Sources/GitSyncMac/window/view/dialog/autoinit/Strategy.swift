import Foundation
@testable import Utils

extension AutoInitConflict{
    enum Strategy{
        
    }
}
//    /**
//     * New
//     */
//    var conflict:(issue:String,proposal:String){
//        var issue:String = ""
//        var proposal:String = ""
//        if pathExists == false {
//            issue = "There is no folder in the file path: " + "\(repoItem.localPath)"
//            proposal = "Do you want to create it and download from remote?"
//        }else if pathExists && hasPathContent == false{
//            issue = "There is no content in the file path: " + "\(repoItem.localPath)"
//            proposal = "Do you want to download from remote?"
//        }else if pathExists && hasPathContent{
//            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
//            proposal = "Do you want to download from remote and initiate a merge wizard?"
//        }
//        return (issue,proposal)
//    }


//enum PathExists{
//    enum HasPathContent{
//        enum IsGitRepo{
//            case yes
//            case no
//        }
//        case yes(isGitRepo:IsGitRepo)
//        case no(isGitRepo:IsGitRepo)
//    }
//    case yes(hasContent:HasPathContent)
//    case no(hasContent:HasPathContent)
//}
//case configure(pathExists:PathExists)
///**
// * Creates a strategy
// */
//static func strategy(_ pathExists:Bool,_ isGitRepo:Bool,_ hasPathContent:Bool) -> Strategy{
//    let _isGitRepo:Strategy.PathExists.HasPathContent.IsGitRepo = isGitRepo ? .yes : .no
//    let _hasPathContent:Strategy.PathExists.HasPathContent = hasPathContent ? .yes(isGitRepo:_isGitRepo) : .no(isGitRepo:_isGitRepo)
//    let _pathExists:Strategy.PathExists = pathExists ? .yes(hasContent:_hasPathContent) : .no(hasContent:_hasPathContent)
//    return .configure(pathExists:_pathExists)
//}
