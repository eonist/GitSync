import Foundation
@testable import Utils

class AutoSync {
    static var repoList:[RepoItem]?
    static var idx:Int?
    static var onAllCommitAndPushComplete:()->Void = {fatalError("⚠️️⚠️️⚠️️ a callback method must be attached")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     * TODO: ⚠️️ Try to use dispathgroups instead
     */
    static func initSync(_ onComplete:@escaping ()->Void){
        //Swift.print("🔁 AutoSync.initSync() 🔁")
        onAllCommitAndPushComplete = onComplete
        repoList = RepoUtils.repoListFlattenedOverridden
        idx = 0//reset the idx
        repoList?.indices.forEach { i in /*all the initCommit calls are non-waiting. */
            GitSync.initCommit(repoList!,i,onCommitComplete)//🚪⬅️️ Enter the AutoSync process here
        }
    }
    /**
     * When a push is compelete this method is called
     */
    static func onPushComplete(_ hasPushed:Bool){
        Swift.print("🚀🏁 AutoSync.onPushComplete() hasPushed: " + "\(hasPushed ? "✅":"🚫")")
        idx? += 1
        if(idx == repoList?.count){//TODO: ⚠️️ USE dispatchgroup instead
            Swift.print("🏁🏁🏁 AutoSync.swift All repos are now AutoSync'ed")//now go and read commits to list
            onAllCommitAndPushComplete()/*All commits and pushes was completed*/
        }
    }
    /**
     * When a commit has competed this method is called
     */
    static func onCommitComplete(_ idx:Int, _ hasCommited:Bool){
        Swift.print("🔨 AutoSync.onCommitComplete() hasCommited: " + "\(hasCommited ? "✅" : "🚫")")
        GitSync.initPush(repoList!,idx,onPushComplete)
    }
}
