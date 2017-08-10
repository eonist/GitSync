import Foundation
@testable import Utils

class AutoInitConflict{
    let repoItem:RepoItem
    lazy var pathExists:Bool = {
        return Utils.pathExists(self.repoItem)
    }()
    lazy var isGitRepo:Bool = {
        return self.pathExists && Utils.isGitRepo(self.repoItem)
    }()
    lazy var hasPathContent:Bool = {
        return self.pathExists && !self.isGitRepo && Utils.hasPathContent(self.repoItem)
    }()
//    let strategy:Strategy
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
    }
}
