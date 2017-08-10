import Foundation
@testable import Utils

struct AutoInitConflict{
  
    let repoItem:RepoItem
 
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
    
    }
}
extension AutoInitConflict{
    var pathExists:Bool {
        return FileAsserter.exists(repoItem.localPath)
    }
    var isGitRepo:Bool {
        return GitAsserter.isGitRepo(repoItem.localPath)
    }
    
    var hasPathContent:Bool {
        return FileAsserter.hasContent(repoItem.localPath)
    }//TODO: ⚠️️ make priv get pub set
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
        let pathExists = self.pathExists
        if pathExists == false {
            issue = "There is no folder in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to create it and download from remote?"
            return (issue,proposal)
        }
        let hasPathContent = self.hasPathContent
        if pathExists && hasPathContent == false{
            issue = "There is no content in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote?"
            return (issue,proposal)
        }
        if pathExists && hasPathContent{
            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote and initiate a merge wizard?"
            return (issue,proposal)
        }else{
            fatalError("this case cant happen")
        }
        
    }
}
