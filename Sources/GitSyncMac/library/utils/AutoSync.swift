import Foundation
@testable import Utils

class AutoSync {
    static var repoList:[RepoItem]?
    static var group:DispatchGroup?
    //static var onAllCommitAndPushComplete:()->Void = {fatalError("⚠️️⚠️️⚠️️ a callback method must be attached")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * TODO: ⚠️️ Try to use dispathgroups instead
     */
    static func initSync(_ onComplete:@escaping ()->Void){
        //Swift.print("🔁 AutoSync.initSync() 🔁")
        //onAllCommitAndPushComplete = onComplete
        repoList = RepoUtils.repoListFlattenedOverridden
        group = DispatchGroup()
        group?.notify(queue: main, execute: {/*you have to jump back on main thread to call things on main thread as this scope is still on bg thread*/
            Swift.print("🏁🏁🏁 AutoSync.swift All repos are now AutoSync'ed")//now go and read commits to list
            onComplete()/*All commits and pushes was completed*/
        })
        repoList?.indices.forEach { i in /*all the initCommit calls are non-waiting. */
            GitSync.initCommit(repoList!,i,onCommitComplete)//🚪⬅️️ Enter the AutoSync process here
        }
        
    }
    /**
     * When a push is compelete this method is called
     */
    /*static func onPushComplete(_ hasPushed:Bool){
     //Swift.print("🚀🏁 AutoSync.onPushComplete() hasPushed: " + "\(hasPushed ? "✅":"🚫")")
     
     }*/
    /**
     * When a commit has competed this method is called
     */
    static func onCommitComplete(_ idx:Int, _ hasCommited:Bool){
        Swift.print("🔨 AutoSync.onCommitComplete() hasCommited: " + "\(hasCommited ? "✅" : "🚫")")
        
        GitSync.initPush(repoList!,idx,group!)
    }
}
