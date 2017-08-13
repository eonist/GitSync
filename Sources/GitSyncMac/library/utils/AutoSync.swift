import Foundation
@testable import Utils
/**
 * Takes care of staging, commiting, Pulling, pushing etc
 */
class AutoSync {
    typealias AutoSyncComplete = ()->Void
    static let shared = AutoSync()//TODO: ⚠️️ this does not need to be shared
    var repoList:[RepoItem]?
//    var messageRepos:[RepoItem]?
    var otherRepos:[RepoItem]?/*auto message*/
    var countForRepoWithMSG:Int = 0
    var autoSyncComplete:AutoSyncComplete = {fatalError("Must attach onComplete handler")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    func initSync(_ onComplete:@escaping AutoSyncComplete){
        countForRepoWithMSG = 0/*reset*/
        autoSyncComplete = onComplete
        let repoList:[RepoItem] = RepoUtils.repoListFlattenedOverridden/*re-new the repo list*/
        self.repoList = repoList
        var curRepoIndex:Int = 0
        func iterateRepoItems(){
            if curRepoIndex < repoList.count {
                let repoItem = repoList[curRepoIndex]
                curRepoIndex += 1
                self.verifyGitProject(repoItem,iterateRepoItems)
            }else{
                onVerificationComplete()
            }
        }
        iterateRepoItems()
    }
    /**
     * New
     */
    private func onVerificationComplete(){
        let messageRepos:[RepoItem] = repoList!.filter{$0.message}/*manual message*/
        otherRepos = repoList!.filter{!$0.message}
        if !messageRepos.isEmpty {
            incrementCountForRepoWithMSG(messageRepos)
        }else if otherRepos != nil && !otherRepos!.isEmpty {
            syncOtherRepos()
        }else {/*nothing to sync, return*/
            autoSyncComplete()
        }
    }
    /**
     * New
     */
    private func incrementCountForRepoWithMSG(_ messageRepos:[RepoItem]){
        if countForRepoWithMSG < messageRepos.count {
            let repoItem:RepoItem = messageRepos[countForRepoWithMSG]
            countForRepoWithMSG += 1
            if let commitMessage:CommitMessage = CommitMessageUtils.generateCommitMessage(repoItem.local) {//if no commit msg is generated, then no commit is needed
                Nav.setView(.dialog(.commit(repoItem,commitMessage,{self.incrementCountForRepoWithMSG(messageRepos)})))/*this view eventually calls initCommit*/
            }else {
                MergeUtils.manualMerge(repoItem){/*nothing to commit but  check if remote has updates*/
                    self.incrementCountForRepoWithMSG(messageRepos)/*nothing to commit, iterate*/
                }
            }
        }else{/*aka complete*/
            syncOtherRepos()
        }
    }
    /**
     * New
     */
    private func syncOtherRepos(){
        let group:DispatchGroup = DispatchGroup()
        otherRepos?.forEach { repoItem in/*all the initCommit calls are non-waiting. */
            group.enter()
            bg.async {
                GitSync.initCommit(repoItem,nil,{/*Swift.print("autoSyncGroup.leave: \(self)");*/group.leave()})//🚪⬅️️ Enter the AutoSync process here, its wrapped in a bg thread because hwne oush complets it jumps back on the main thread
            }
        }
        group.notify(queue: main){//it also fires when nothing left or entered
            self.autoSyncComplete()/*All commits and pushes was completed*/
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
}

