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
        case a
        case b
        case c
        case d
        /**
         *
         */
        static func strategy(doesPathExist:Bool,isGitFolder:Bool,isFolderEmpty:Bool) -> Strategy{
            return .a
        }
        /**
         *
         */
        static func process(){
            //do git stuff
        }
        /**
         *
         */
        var text:(issue:String,proposal:String){
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
