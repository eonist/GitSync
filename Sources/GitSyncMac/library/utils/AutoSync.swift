import Foundation
@testable import Utils
/**
 * NOTE: It seems its dificult to add Dispatch group to this, as all commits are fired of at once and depending on its result a subsequent push is called
 */
class AutoSync {
    static let shared = AutoSync()
    var repoList:[RepoItem]?
    var messageList:[RepoItem]?
    var msgCount:Int = 0
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
        repoList = RepoUtils.repoListFlattenedOverridden/*re-new the repo list*/
        messageList = repoList?.filter{$0.message}
        
        if let messageList = messageList, !messageList.isEmpty {
            Nav.setView(.dialog(.commit))/*⬅️️🚪*/
        }
        
//        repoList.filter{!$0.message}.forEach { repoItem in/*all the initCommit calls are non-waiting. */
//            
//            if repoItem.message {
//                //prompt user
//                Nav.setView(.dialog(.commit))
//            }
//            autoSyncGroup?.enter()
//            GitSync.initCommit(repoItem,onPushComplete)//🚪⬅️️ Enter the AutoSync process here
//        }
    }
    /**
     * When a singular push is compelete this method is called
     */
    func onPushComplete(_ hasPushed:Bool){
        Swift.print("onPushComplete")
        autoSyncGroup?.leave()
    }
}
