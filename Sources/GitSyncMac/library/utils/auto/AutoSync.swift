import Foundation
@testable import Utils
/**
 * Takes care of staging, commiting, Pulling, pushing etc
 */
class AutoSync {
    typealias AutoSyncCompleted = ()->Void
    lazy var messageRepoIterator:MessageRepoIterator = createMessageRepoIterator()
    
    lazy var repoList:[RepoItem] = self.createRepoList()
    lazy var otherRepos = repoList.filter{!$0.message}/*Auto message*/
    let autoSyncComplete:AutoSyncCompleted/*When the AutoSync completes this is fired*/
    var isUserInitiated:Bool/*if interval initiated then only target repos that have interval set to true*/
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    init(isUserInitiated:Bool, onComplete:@escaping AutoSyncCompleted) {
        self.isUserInitiated = isUserInitiated
        self.autoSyncComplete = onComplete
        let repoVerifier = RepoVerifier(array:repoList,onComplete:onAllReposVerified)
        repoVerifier.iterateAll()
    }
}
