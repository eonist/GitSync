import Foundation
@testable import Utils

struct AutoInitConflict{
    let repoItem:RepoItem
    let pathExists:Bool
    let isGitRepo:Bool
    let hasPathContent:Bool
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
        self.pathExists = Utils.pathExists(repoItem)
        let isGitRepo = pathExists && Utils.isGitRepo(repoItem)
        self.isGitRepo = isGitRepo
        self.hasPathContent = self.pathExists && !isGitRepo && Utils.hasPathContent(repoItem)
    }
}
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
        static func create(pathExists:Bool,isGitRepo:Bool,hasPathContent:Bool) -> Strategy{
            let _isGitRepo:Strategy.PathExists.HasPathContent.IsGitRepo = isGitRepo ? .yes : .no
            let _hasPathContent:Strategy.PathExists.HasPathContent = hasPathContent ? .yes(isGitRepo:_isGitRepo) : .no(isGitRepo:_isGitRepo)
            let _pathExists:Strategy.PathExists = pathExists ? .yes(hasContent:_hasPathContent) : .no(hasContent:_hasPathContent)
            return .configure(pathExists:_pathExists)
        }
        /**
         *
         */
        static func process(){
            //do git stuff
        }
        /**
         * Creates the text for the AutoInitPrompt
         */
        func text(_ repoItem:RepoItem) -> (issue:String,proposal:String){
            var issue:String = ""
            var proposal:String = ""
            /**/
            switch self{
            case .configure(let pathExists):
                switch pathExists {
                case .yes(let hasContent):
                    switch hasContent {
                    case .yes(let isGitRepo):
                        switch isGitRepo {
                        case .yes:
                            let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
                            if curRemotePath != repoItem.remotePath {
                                issue = "There is already a git project in the folder: \(repoItem.local) with a different remote URL"
                                proposal = "Do you want to assign a new remote URL and start a merge wizard?"
                            }
                        case .no:
                            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
                            proposal = "Do you want to download from remote and start a merge wizard?"
                        }
                    case .no(let isGitRepo):
                        _ = isGitRepo
                        issue = "There is no content in the file path: " + "\(repoItem.localPath)"
                        proposal = "Do you want to download from remote?"
                    }
                case .no(let hasContent):
                    _ = hasContent
                    issue = "There is nothing in the path \(repoItem.localPath)"
                    proposal = "Do you want to create it and download files from: \(repoItem.remotePath)"
                }
            }
            return (issue,proposal)
        }
    }
    
}
private class Utils{
    static func pathExists(_ repoItem:RepoItem)->Bool {
        return FileAsserter.exists(repoItem.localPath)
    }
    static func isGitRepo(_ repoItem:RepoItem)->Bool {
        return GitAsserter.isGitRepo(repoItem.localPath)
    }
    static func hasPathContent(_ repoItem:RepoItem)->Bool {
        return FileAsserter.hasContent(repoItem.localPath)
    }
}
extension AutoInitConflict{
    //TODO: ⚠️️ make priv get pub set
    static let dummyData:AutoInitConflict = {
        //        let issue:String = "There is no folder in the file path: ~/dev/demo3"
        //        let proposal:String = "Do you want to create it and download from remote?"
        return AutoInitConflict(RepoItem(local: "~/dev/demo",branch: "master",title: "demo")/*pathExists:false,isGitRepo:false,hasPathContent:false*/)
    }()
    /**
     * New
     */
    var conflict:(issue:String,proposal:String){
        var issue:String = ""
        var proposal:String = ""
        if pathExists == false {
            issue = "There is no folder in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to create it and download from remote?"
        }else if pathExists && hasPathContent == false{
            issue = "There is no content in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote?"
        }else if pathExists && hasPathContent{
            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote and initiate a merge wizard?"
        }
        return (issue,proposal)
    }
}