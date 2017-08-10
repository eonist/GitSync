import Foundation
@testable import Utils

struct AutoInitConflict{
    let repoItem:RepoItem
    let pathExists:Bool
    let isGitRepo:Bool
    let hasPathContent:Bool
//    let strategy:Strategy
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
        self.pathExists = Utils.pathExists(repoItem)
        let isGitRepo = pathExists && Utils.isGitRepo(repoItem)
        self.isGitRepo = isGitRepo
        self.hasPathContent = self.pathExists && !isGitRepo && Utils.hasPathContent(repoItem)
//        self.strategy = Strategy.strategy()
    }
}
extension AutoInitConflict{
//    typealias State = (pathExists:Bool,isGitRepo:Bool,hasPathContent:Bool)
    typealias TextData = (issue:String,proposal:String)
    /**
     * Creates the text for the AutoInitPrompt
     */
    var text:TextData{
        var issue:String = ""
        var proposal:String = ""
        
        switch (pathExists,hasPathContent,isGitRepo) {
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
            issue = "There is no content in the path: " + "\(repoItem.localPath)"
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
    func process(){
        switch (pathExists,hasPathContent,isGitRepo) {
        case (true,true,true):
            let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
            if curRemotePath != repoItem.remotePath {//--the .git folder already has a remote repo attached
                _ = GitModifier.detachRemoteRepo(repoItem.localPath/*branch*/)//--promt the user if he wants to use the existing remote origin, this will skip the user needing to input a remote url
                _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.remotePath)
            }else if curRemotePath == repoItem.remotePath{
                //do nothing
            }else{//--does not have remote repo attached// GitAsserter.hasRemoteRepoAttached(localPath, branch)
                _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.remotePath)//--attach remote repo
            }
        case (true,true,false):
            _ = GitModifier.initialize(repoItem.localPath)
            _ = GitModifier.attachRemoteRepo(repoItem.localPath,repoItem.branch)//--add new remote origin
        case (true,false,_):
            _ = GitModifier.clone(repoItem.remotePath,repoItem.localPath)
        case (false,_,_):
            _ = GitModifier.clone(repoItem.remotePath,repoItem.localPath)//--this will also create the folders if they dont exist, even nested
        default:
            fatalError("Has no strategy for this scenario ")
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
        var repoItem:RepoItem = RepoItem(local: "~/dev/demo",branch: "master",title: "demo",remote: "https://www.github.com/gitsync/demo.git")
        return AutoInitConflict(repoItem)
    }()
}
