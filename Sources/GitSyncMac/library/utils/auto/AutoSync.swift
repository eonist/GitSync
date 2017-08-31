import Foundation
@testable import Utils
/**
 * Takes care of staging, commiting, Pulling, pushing etc
 */
class AutoSync {
    typealias AutoSyncCompleted = ()->Void
    lazy var messageRepoIterator:MessageRepoIterator = createMessageRepoIterator()
    let repoList:[RepoItem]/*All repos*/
    lazy var otherRepos = repoVerifier.verifiedRepos.filter{!$0.message}/*"Verified" and "auto message" repos*/
    lazy var repoVerifier = RepoVerifier(array:repoList,onComplete:onAllReposVerified)/*⬅️️*/
    let autoSyncComplete:AutoSyncCompleted/*When the AutoSync completes this is fired*/
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * PARAM: isUserInitiated: if interval initiated then only target repos that have interval set to true
     */
    init(isUserInitiated:Bool, onComplete:@escaping AutoSyncCompleted) {
        self.autoSyncComplete = onComplete
        self.repoList = AutoSync.createRepoList(isUserInitiated:isUserInitiated)
        Swift.print("self.repoList.count: " + "\(self.repoList.count)")
        repoVerifier.iterate()
    }
}
