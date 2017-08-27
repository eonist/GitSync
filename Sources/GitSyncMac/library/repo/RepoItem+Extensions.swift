import Foundation
@testable import Utils

extension RepoItem{
    var localPath:String {get {return local} set{local = newValue}}
    var remotePath:String {get {return remote} set{remote = newValue}}
    var gitRepo:GitRepo {
        return GitRepo.gitRepo(self.local, remotePath, self.branch)
    }//temp
    static func repoItem(_ gitRepo:GitRepo) -> RepoItem {
        var repoItem = RepoItem()
        repoItem.local = gitRepo.localPath
        repoItem.remote = "https://" + gitRepo.remotePath
        repoItem.branch = gitRepo.branch
        return repoItem
    }
    static var dummyData:RepoItem {
        return RepoItem(local: "user file path",branch: "master",title: "Element iOS")
    }
}

