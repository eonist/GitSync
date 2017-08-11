import Foundation
@testable import Utils
/**
 * Note: We dont use a struct here because struct doesnt do lazy var
 */
class AutoInitConflict{
    let repoItem:RepoItem
    lazy var pathExists:Bool = {
        return FileAsserter.exists(self.repoItem.localPath.tildePath)
    }()
    lazy var hasPathContent:Bool = {
        guard self.pathExists else{return false}
        return FileAsserter.hasContent(self.repoItem.localPath.tildePath)
    }()
    lazy var isGitRepo:Bool = {
        guard self.pathExists else {return false}
        return GitAsserter.isGitRepo(self.repoItem.localPath.tildePath)
    }()
    lazy var areRemotesEqual:Bool = {
        guard self.isGitRepo else{return false}
        Swift.print("curRemotePath: " + ">\(curRemotePath)<")
        Swift.print("repoItem.remotePath: " + ">\(repoItem.remotePath)<")
        return self.curRemotePath == self.repoItem.remotePath
    }()
    lazy var curRemotePath:String = {
       return GitParser.originUrl(self.repoItem.localPath)
    }()
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
    }
}
