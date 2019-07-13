/**
 * Parsers
 */
extension RepoItem {
    /**
     * Converts GitRepo to RepoItem
     */
    var gitRepo: GitRepo {
        return GitRepo.gitRepo(self.local, remotePath, self.branch)
    }
    /**
     * Converts GitRepo to RepoItem
     */
    static func repoItem(_ gitRepo: GitRepo) -> RepoItem {
        var repoItem = RepoItem()
        repoItem.local = gitRepo.localPath
        repoItem.remote = "https://" + gitRepo.remotePath
        repoItem.branch = gitRepo.branch
        return repoItem
    }
}
