/**
 * Type
 */
extension Refresh {
    typealias RefreshReposComplete = () -> Void
    typealias RefreshRepoComplete = () -> Void
    typealias CommitItemsComplete = (_ results: [String]) -> Void
    typealias CommitCountComplete = (_ commitCount: Int) -> Void
 }
