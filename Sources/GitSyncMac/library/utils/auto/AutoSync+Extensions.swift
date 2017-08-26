import Foundation
@testable import Utils
/**
 * Methods
 */
extension AutoSync{
    /**
     * Increment count
     */
    private func incrementCountForRepoWithMSG(/*_ messageRepos:[RepoItem],*/_ otherRepos:[RepoItem]){
        if messageRepoIterator.hasNext() {//curIdxForRepoWithMessage < messageRepos.count
            let repoItem:RepoItem = messageRepoIterator.next()//messageRepos[curIdxForRepoWithMessage]
            if let commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repoItem.local) {//if no commit msg is generated, then no commit is needed
                Nav.setView(.dialog(.commit(repoItem,commitMessage,{self.incrementCountForRepoWithMSG(/*messageRepos,*/otherRepos)})))/*this view eventually calls initCommit*/
            }else {
                MergeUtils.manualMerge(repoItem){/*nothing to commit but  check if remote has updates*/
                    self.incrementCountForRepoWithMSG(/*messageRepos,*/otherRepos)/*nothing to commit, iterate*/
                }
            }
        }else{/*aka completed manual-message-repos*/
            syncOtherRepos(otherRepos)
        }
    }
    
    /**
     * Syncs non-manual-message repos
     */
    private func syncOtherRepos(_ otherRepos:[RepoItem]){
        let group = DispatchGroup()
        otherRepos.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            group.enter()
            bg.async {
                GitSync.initCommit(repoItem,nil,{/*Swift.print("autoSyncGroup.leave: \(self)");*/group.leave()})//🚪⬅️️ Enter the AutoSync process here, its wrapped in a bg thread because hwne oush complets it jumps back on the main thread
            }
        }
        group.notify(queue: main){//It also fires when nothing left or entered
            self.autoSyncComplete()/*All commits and pushes was completed*/
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
    private func onVerificationComplete(){
        if !messageRepoIterator.isEmpty {
            incrementCountForRepoWithMSG(/*messageRepos*/otherRepos)
        }else if !otherRepos.isEmpty {
            syncOtherRepos(otherRepos)
        }else {/*Nothing to sync, return*/
            autoSyncComplete()
        }
    }
    /**
     * Generates the repoList
     */
    func createRepoList() -> [RepoItem]{
        let repoList = RepoUtils.repoListFlattenedOverridden/*Get the latest repo list*/
        return isUserInitiated ? repoList : repoList.filter{$0.auto}/*if interval initiated then only target repos that have interval set to true*/
    }
    /**
     * Generates the MessageRepoIterator
     */
    func createMessageRepoIterator() -> MessageRepoIterator{
        let messageRepos:[RepoItem] = repoList.filter{$0.message}/*repos that have manual commit message*/
        return .init(array:messageRepos)
    }
}

