import Foundation
@testable import Utils
/**
 * Methods
 */
extension AutoSync{
    /**
     * Syncs auto-message repos
     * NOTE: Also works if Nothing to sync
     */
    private func syncOtherRepos(){
        let group = DispatchGroup()
        otherRepos.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            group.enter()
            bg.async {
                GitSync.initCommit(repoItem,nil,{group.leave()})/*🚪⬅️️ Enter the AutoSync process here, it's wrapped in a bg thread because hwne oush complets it jumps back on the main thread*/
            }
        }
        group.notify(queue: main){//It also fires when nothing left or entered
            self.autoSyncComplete(self.repoVerifier.verifiedRepos)/*All commits and pushes was completed*/
        }
    }
}
/**
 * Event handlers
 */
extension AutoSync{
    /**
     * This is called when all repos are verified that they exist locally and remotly
     */
    func onAllReposVerified(){
        if !messageRepoIterator.isEmpty {
            messageRepoIterator.iterate()/*Iterate over repos with manual commit message*/
        }
    }
}
/**
 * Generators
 */
extension AutoSync{
    /**
     * Generates the repoList
     */
    static func createRepoList(isUserInitiated:Bool) -> [RepoItem]{
        let repoList = RepoUtils.repoListFlattenedOverridden/*Get the latest repo list*/
//        Swift.print("repoList.count: " + "\(repoList.count)")
//        repoList.forEach{
//            Swift.print("$0: " + "\($0)")
//        }
        return isUserInitiated ? repoList : repoList.filter{$0.auto}/*if interval initiated then only target repos that have interval set to true*/
    }
    /**
     * Generates the MessageRepoIterator
     */
    func createMessageRepoIterator() -> MessageRepoIterator{
        let verifiedRepos = repoVerifier.verifiedRepos
        let messageRepos:[RepoItem] = verifiedRepos.filter{$0.message}/*repos that have manual commit message*/
//        Swift.print("messageRepos.count: " + "\(messageRepos.count)")
        return .init(array:messageRepos,onComplete:syncOtherRepos)
    }
}
