import Foundation
@testable import Utils
/**
 * NOTE: It seems its dificult to add Dispatch group to this, as all commits are fired of at once and depending on its result a subsequent push is called
 */
class AutoSync {
    typealias AutoSyncComplete = ()->Void
    static let shared = AutoSync()
    var repoList:[RepoItem]?
    var messageRepos:[RepoItem]?
    var otherRepos:[RepoItem]?
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
        self.autoSyncComplete = onComplete
        autoSyncGroup = DispatchGroup()
        autoSyncGroup?.notify(queue: main){
            Swift.print("🏁🏁🏁 AutoSyncGroup: All repos are now AutoSync'ed")//now go and read commits to list
            onComplete()/*All commits and pushes was completed*/
        }
        repoList = RepoUtils.repoListFlattenedOverridden/*re-new the repo list*/
        messageRepos = repoList?.filter{$0.message} ?? []
        otherRepos = repoList?.filter{!$0.message} ?? []
        incrementCountForRepoWithMSG()
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
        
        Swift.print("listSansMSG: " + "\(otherRepos)") 
        otherRepos.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            autoSyncGroup?.enter()
            GitSync.initCommit(repoItem,onPushComplete)//🚪⬅️️ Enter the AutoSync process here
        }
        if otherRepos.isEmpty {
            autoSyncComplete!()
        }
    }
    /**
     * When a singular push is compelete this method is called
     */
    func onPushComplete(){
        Swift.print("onPushComplete")
        autoSyncGroup?.leave()
    }
}
