import Foundation
@testable import Utils
/**
 * NOTE: It seems its dificult to add Dispatch group to this, as all commits are fired of at once and depending on its result a subsequent push is called
 */
class AutoSync {
    static let shared = AutoSync()
    lazy var repoList:[RepoItem] = RepoUtils.repoListFlattenedOverridden
    var autoSyncGroup:DispatchGroup?
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * TODO: ⚠️️ Try to use dispathgroups instead
     */
    func initSync(_ onComplete:@escaping ()->Void){
        //Swift.print("🔁 AutoSync.initSync() 🔁")
        autoSyncGroup = DispatchGroup()
        autoSyncGroup?.notify(queue: main){
            Swift.print("🏁🏁🏁 AutoSync.swift All repos are now AutoSync'ed")//now go and read commits to list
            onComplete()/*All commits and pushes was completed*/
        }
        repoList = RepoUtils.repoListFlattenedOverridden//re-new the repo list
        repoList.indices.forEach { i in /*all the initCommit calls are non-waiting. */
            autoSyncGroup?.enter()
            GitSync.initCommit(repoList,i,onPushComplete,onCommitComplete)//🚪⬅️️ Enter the AutoSync process here
        }
    }
    /**
     * When a singular commit has competed this method is called
     */
    func onCommitComplete(_ idx:Int, _ hasCommited:Bool){
        fatalError("bug")
        //Swift.print("🔨 AutoSync.onCommitComplete() hasCommited: " + "\(hasCommited ? "✅" : "🚫")")
//        GitSync.initPush(repoList[idx],onComplete:onPushComplete)
    }
    /**
     * When a singular push is compelete this method is called
     */
    func onPushComplete(_ hasPushed:Bool){
        autoSyncGroup?.leave()
    }
}
