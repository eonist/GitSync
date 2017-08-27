import Foundation
@testable import Utils
/**
 * Accessors
 */
extension RepoItem{
    var localPath:String {get {return local} set{local = newValue}}
    var remotePath:String {get {return remote} set{remote = newValue}}
}
/**
 * Parsers
 */
extension RepoItem{
    /**
     * Converts GitRepo to RepoItem
     */
    var gitRepo:GitRepo {
        return GitRepo.gitRepo(self.local, remotePath, self.branch)
    }
    /**
     * Converts GitRepo to RepoItem
     */
    static func repoItem(_ gitRepo:GitRepo) -> RepoItem {
        var repoItem = RepoItem()
        repoItem.local = gitRepo.localPath
        repoItem.remote = "https://" + gitRepo.remotePath
        repoItem.branch = gitRepo.branch
        return repoItem
    }
}
/**
 * Initializers
 */
extension RepoItem{
    /**
     * Basic
     */
    static func repoItem(local:String,branch:String,title:String,remote:String = "") -> RepoItem{
        var repoItem:RepoItem = RepoItem()
        repoItem.local = local
        repoItem.branch = branch
        repoItem.title = title
        repoItem.remote = remote
        return repoItem
    }
    /**
     * DummyData
     */
    static var dummyData:RepoItem {
        return RepoItem.repoItem(local: "user file path",branch: "master",title: "Element iOS")
    }
}
