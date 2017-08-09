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
    var autoSyncComplete:AutoSyncComplete = {fatalError("Must attach onComplete handler")}
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
        Swift.print("messageRepos.count: " + "\(messageRepos!.count)")
        otherRepos = repoList?.filter{!$0.message} ?? []
        Swift.print("otherRepos.count: " + "\(otherRepos!.count)")
        if messageRepos != nil && !messageRepos!.isEmpty {
            Swift.print("has repos that has manual msg")
            incrementCountForRepoWithMSG()
        }else if otherRepos != nil && !otherRepos!.isEmpty {
            Swift.print("has repos that has auto msg")
            syncOtherRepos()
        }else {//nothing to sync, return
            Swift.print("nothing to sync, return")
            autoSyncComplete()
        }
    }
    /**
     * New
     */
    func incrementCountForRepoWithMSG(){
        Swift.print("incrementCountForRepoWithMSG 🍏 curIndex: \(countForRepoWithMSG) of tot: \(messageRepos!.count)")
        if countForRepoWithMSG < messageRepos!.count {
            let repo = messageRepos![countForRepoWithMSG]
            countForRepoWithMSG += 1
            if let commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repo.local) {//if no commit msg is generated, then no commit is needed
                Swift.print("something to commit")
                Nav.setView(.dialog(.commit(repo,commitMessage)))/*⬅️️🚪 this view eventually calls initCommit*/
            }else {
                Swift.print("nothing to commit")
                MergeUtils.manualMerge(repo){//nothing to commit but  check if remote has updates
                    self.incrementCountForRepoWithMSG()//nothing to commit, iterate
                }
            }
        }else{//aka complete
            syncOtherRepos()
        }
    }
    /**
     * New
     */
    private func syncOtherRepos(){
        Swift.print("AutoSync.syncOtherRepos() 🍊 ")
        autoSyncGroup = DispatchGroup()
        
        otherRepos?.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            self.autoSyncGroup?.enter()
            bg.async {
                
                AutoSync.initCommitProcess(repoItem,nil,{Swift.print("autoSyncGroup.leave");self.autoSyncGroup?.leave()})//🚪⬅️️ Enter the AutoSync process here, its wrapped in a bg thread because hwne oush complets it jumps back on the main thread
            }
            
        }
//        if let otherRepos = otherRepos, otherRepos.isEmpty {
//            autoSyncComplete()//retur early if there were no other repos
//        }
        autoSyncGroup?.notify(queue: main){//it also fires when nothing left or entered
            Swift.print("🏁🏁🏁 AutoSyncGroup: All repos are now AutoSync'ed")//now go and read commits to list
            self.autoSyncComplete()/*All commits and pushes was completed*/
        }
    }
    /**
     * New
     */
    static func initCommitProcess(_ repoItem:RepoItem, _ commitMessage:CommitMessage? = nil, _ onComplete:@escaping ()->Void){
        let pathExists:Bool = FileAsserter.exists(repoItem.localPath)
        let is 
        if pathExists == false {
             Nav.setView(.dialog(.autoInit(AutoInitConflict.dummyData)))
           
        }
        Swift.print("pathExists: " + "\(pathExists)")
        GitSync.initCommit(repoItem, commitMessage, onComplete)
    }
}
