import Foundation
@testable import Utils
/**
 * Takes care of staging, commiting, Pulling, pushing etc
 */
class AutoSync {
    typealias AutoSyncCompleted = ([RepoItem])->Void
    
    let repoList:[RepoItem]/*All repos*/
    lazy var otherRepos = repoVerifier.verifiedRepos.filter{!$0.message}/*"Verified" and "auto message" repos*/
    lazy var repoVerifier = RepoVerifier.init(array:repoList,onComplete:onAllReposVerified)/*Step.1*/
    lazy var messageRepoIterator:MessageRepoIterator = createMessageRepoIterator(verifiedRepos:repoVerifier.verifiedRepos)/*Step.2*/
    let autoSyncComplete:AutoSyncCompleted/*When the AutoSync completes this is fired*/
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * PARAM: isUserInitiated: if interval initiated then only target repos that have interval set to true
     */
    init(isUserInitiated:Bool, onComplete:@escaping AutoSyncCompleted) {
        Swift.print("AutoSync isUserInitiated: \(isUserInitiated)")
        self.autoSyncComplete = onComplete
        self.repoList = AutoSync.createRepoList(isUserInitiated:isUserInitiated)
        Swift.print("self.repoList.count: " + "\(self.repoList.count)")
        repoVerifier.iterate()
    }
}
