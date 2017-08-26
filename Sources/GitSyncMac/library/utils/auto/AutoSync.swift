import Foundation
@testable import Utils
/**
 * Takes care of staging, commiting, Pulling, pushing etc
 */
class AutoSync {
    typealias AutoSyncCompleted = ()->Void
//    var messageRepoIterator 🏀
    var curIdxForRepoWithMessage:Int/*The iteration cursor*/
    let autoSyncComplete:AutoSyncCompleted/*When the AutoSync completes this is fired*/ // = {fatalError("Must attach onComplete handler")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    init(isUserInitiated:Bool, onComplete:@escaping AutoSyncCompleted) {
        self.curIdxForRepoWithMessage = 0
        self.autoSyncComplete = onComplete
        let repoList:[RepoItem] = {
            let repoList = RepoUtils.repoListFlattenedOverridden/*Get the latest repo list*/
            return isUserInitiated ? repoList : repoList.filter{$0.auto}/*if interval initiated then only target repos that have interval set to true*/
        }()
        var curRepoIndex:Int = 0
        func iterateRepoItems(){
            if curRepoIndex < repoList.count {
                let repoItem = repoList[curRepoIndex]
                curRepoIndex += 1
                self.verifyGitProject(repoItem,iterateRepoItems)
            }else{
                onVerificationComplete(repoList)
            }
        }
        iterateRepoItems()
    }
}
/**
 * Methods
 */
extension AutoSync{
    /**
     * Increment count
     */
    private func incrementCountForRepoWithMSG(_ messageRepos:[RepoItem],_ otherRepos:[RepoItem]){
        if curIdxForRepoWithMessage < messageRepos.count {
            let repoItem:RepoItem = messageRepos[curIdxForRepoWithMessage]
            curIdxForRepoWithMessage += 1
            if let commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repoItem.local) {//if no commit msg is generated, then no commit is needed
                Nav.setView(.dialog(.commit(repoItem,commitMessage,{self.incrementCountForRepoWithMSG(messageRepos,otherRepos)})))/*this view eventually calls initCommit*/
            }else {
                MergeUtils.manualMerge(repoItem){/*nothing to commit but  check if remote has updates*/
                    self.incrementCountForRepoWithMSG(messageRepos,otherRepos)/*nothing to commit, iterate*/
                }
            }
        }else{/*aka completed manual-message-repos*/
            syncOtherRepos(otherRepos)
        }
    }
    /**
     * New
     * NOTE: verifies if a repo exists locally, if not a wizard initiated
     */
    private func verifyGitProject(_ repoItem:RepoItem, _ onComplete:@escaping AutoInitView.Complete){
        let conflict = AutoInitConflict.init(repoItem)
        if conflict.areRemotesEqual {//No need to init AutoInit dialog
            onComplete()
        }else{
            main.async{
                Nav.setView(.dialog(.autoInit(conflict,onComplete)))
            }
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
    private func onVerificationComplete(_ repoList:[RepoItem]){
        let messageRepos:[RepoItem] = repoList.filter{$0.message}/*repos that have manual commit message*/
        let otherRepos = repoList.filter{!$0.message}/*Auto message*/
        if !messageRepos.isEmpty {
            incrementCountForRepoWithMSG(messageRepos,otherRepos)
        }else if !otherRepos.isEmpty {
            syncOtherRepos(otherRepos)
        }else {/*nothing to sync, return*/
            autoSyncComplete()
        }
    }
}
