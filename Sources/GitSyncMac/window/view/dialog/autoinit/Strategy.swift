import Foundation
@testable import Utils

extension AutoInitConflict{
    enum Strategy{
        enum PathExists{
            enum HasPathContent{
                enum IsGitRepo{
                    case yes
                    case no
                }
                case yes(isGitRepo:IsGitRepo)
                case no(isGitRepo:IsGitRepo)
            }
            case yes(hasContent:HasPathContent)
            case no(hasContent:HasPathContent)
        }
        case configure(pathExists:PathExists)
        /**
         * Creates a strategy
         */
        static func strategy(_ pathExists:Bool,_ isGitRepo:Bool,_ hasPathContent:Bool) -> Strategy{
            let _isGitRepo:Strategy.PathExists.HasPathContent.IsGitRepo = isGitRepo ? .yes : .no
            let _hasPathContent:Strategy.PathExists.HasPathContent = hasPathContent ? .yes(isGitRepo:_isGitRepo) : .no(isGitRepo:_isGitRepo)
            let _pathExists:Strategy.PathExists = pathExists ? .yes(hasContent:_hasPathContent) : .no(hasContent:_hasPathContent)
            return .configure(pathExists:_pathExists)
        }
        
        /**
         * Creates the text for the AutoInitPrompt
         */
        func text(_ repoItem:RepoItem) -> (issue:String,proposal:String){
            var issue:String = ""
            var proposal:String = ""
            /**/
           
            let pathExists:Bool = false
            let isGitRepo:Bool = false
            let hasPathContent:Bool = false
        
            switch (pathExists,isGitRepo,hasPathContent) {
            case (true,true,true):
                let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
                if curRemotePath != repoItem.remotePath {
                    issue = "There is already a git project in the folder: \(repoItem.local) with a different remote URL"
                    proposal = "Do you want to assign a new remote URL and start a merge wizard?"
                }
            case (true,true,false):
                issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
                proposal = "Do you want to download from remote and start a merge wizard?"
            case (true,false,_):
                issue = "There is no content in the file path: " + "\(repoItem.localPath)"
                proposal = "Do you want to download from remote?"
            case (false,_,_):
                issue = "There is nothing in the path \(repoItem.localPath)"
                proposal = "Do you want to create it and download files from: \(repoItem.remotePath)"
            default:
                fatalError("Has no strategy for this scenario ")
            }
            
            return (issue,proposal)
        }
        /**
         * NOTE: after this you often want to : MergeUtils.manualMerge(repoItem,{})
         */
        func process(_ repoItem:RepoItem){
            switch self{
            case .configure(let pathExists):
                switch pathExists {
                case .yes(let hasContent):
                    switch hasContent {
                    case .yes(let isGitRepo):
                        switch isGitRepo {
                        case .yes:
                            let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
                            if curRemotePath != repoItem.remotePath {//--the .git folder already has a remote repo attached
                                _ = GitModifier.detachRemoteRepo(repoItem.localPath/*branch*/)//--promt the user if he wants to use the existing remote origin, this will skip the user needing to input a remote url
                                _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.remotePath)
                            }else if curRemotePath == repoItem.remotePath{
                                //do nothing
                            }else{//--does not have remote repo attached// GitAsserter.hasRemoteRepoAttached(localPath, branch)
                                _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.remotePath)//--attach remote repo
                            }
                        case .no:
                            _ = GitModifier.initialize(repoItem.localPath)
                            _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.branch)//--add new remote origin
                        }
                    case .no(let isGitRepo):
                        _ = isGitRepo
                        _ = GitModifier.clone(repoItem.remotePath,repoItem.localPath)
                    }
                case .no(let hasContent):
                    _ = hasContent
                    _ = GitModifier.clone(repoItem.remotePath,repoItem.localPath)//--this will also create the folders if they dont exist, even nested
                }
            }
        }
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
