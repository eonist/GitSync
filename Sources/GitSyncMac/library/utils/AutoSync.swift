import Foundation
@testable import Utils
/**
 * NOTE: It seems its dificult to add Dispatch group to this, as all commits are fired of at once and depending on its result a subsequent push is called
 */
class AutoSync {
    typealias AutoSyncComplete = ()->Void
    static let shared = AutoSync()
    var repoList:[RepoItem]?
    var messageRepos:[RepoItem]?//manual message
    var otherRepos:[RepoItem]?//auto message
    var countForRepoWithMSG:Int = 0
    var autoSyncGroup:DispatchGroup?
    var autoSyncComplete:AutoSyncComplete?
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * TODO: ⚠️️ Try to use dispathgroups instead
     */
    func initSync(_ onComplete:@escaping AutoSyncComplete){
        Swift.print("🔁 AutoSync.initSync() 🔁")
        countForRepoWithMSG = 0//reset
        autoSyncComplete = onComplete
        repoList = RepoUtils.repoListFlattenedOverridden/*re-new the repo list*/
        messageRepos = repoList?.filter{$0.message} ?? []
        otherRepos = repoList?.filter{!$0.message} ?? []
        if messageRepos != nil && !messageRepos!.isEmpty {
            Swift.print("has repos that has manual msg")
            incrementCountForRepoWithMSG()
        }else if otherRepos != nil && !otherRepos!.isEmpty {
            Swift.print("has repos that has auto msg")
            syncOtherRepos()
        }else {//nothing to sync, return
            Swift.print("nothing to sync, return")
            autoSyncComplete!()
        }
    }
    /**
     * New
     */
    func incrementCountForRepoWithMSG(){
        Swift.print("incrementCountForRepoWithMSG")
        Swift.print("countForRepoWithMSG: " + "\(countForRepoWithMSG)")
        Swift.print("repoListThatRequireManualMSG!.count: " + "\(messageRepos!.count)")
        if countForRepoWithMSG < messageRepos!.count {
            let repo = messageRepos![countForRepoWithMSG]
            countForRepoWithMSG += 1
            if let commitMessage = CommitMessageUtils.generateCommitMessage(repo.local) {//if no commit msg is generated, then no commit is needed
                Swift.print("something to commit")
                Nav.setView(.dialog(.commit(repo,commitMessage)))/*⬅️️🚪*/
            }else {
                Swift.print("nothing to commit")
                incrementCountForRepoWithMSG()//nothing to commit, iterate
            }
        }else{//aka complete
            syncOtherRepos()
        }
    }
    /**
     * New
     */
    private func syncOtherRepos(){
        Swift.print("AutoSync.syncRepoItemsWithAutoMessage")
        autoSyncGroup = DispatchGroup()
        
        otherRepos?.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            Swift.print("autoSyncGroup.enter")
            autoSyncGroup?.enter()
            GitSync.initCommit(repoItem,{Swift.print("autoSyncGroup.leave");self.autoSyncGroup?.leave()})//🚪⬅️️ Enter the AutoSync process here
        }
        if otherRepos != nil && otherRepos!.isEmpty {
            autoSyncComplete!()
        }
        autoSyncGroup?.wait()
        autoSyncGroup?.notify(queue: main){
            Swift.print("🏁🏁🏁 AutoSyncGroup: All repos are now AutoSync'ed")//now go and read commits to list
            self.autoSyncComplete!()/*All commits and pushes was completed*/
        }
    }
}
