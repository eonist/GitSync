
/**
 * Initializers
 */
extension RepoItem{
    /**
     * Basic
     */
    static func repoItem(local: String, branch: String, title: String, remote: String = "") -> RepoItem {
        var repoItem: RepoItem = RepoItem()
        repoItem.local = local
        repoItem.branch = branch
        repoItem.title = title
        repoItem.remote = remote
        return repoItem
    }
    /**
     * DummyData
     */
    static var dummyData: RepoItem {
        return RepoItem.repoItem(local: "user file path", branch: "master", title: "Element iOS")
    }
}
