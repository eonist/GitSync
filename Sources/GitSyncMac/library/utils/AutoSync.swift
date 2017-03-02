import Foundation
@testable import Utils

class AutoSync {
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func initSync(_ onComplete:@escaping ()->Void){
        Swift.print("🔁 AutoSync.initSync() 🔁")
        let repoList:[RepoItem] = RepoUtils.repoList
        var idx:Int = 0
        
        func onPushComplete(_ hasPushed:Bool){
            //Swift.print("🚀🏁 AutoSync.onPushComplete() hasPushed: " + "\(hasPushed ? "✅":"🚫")")
            idx += 1
            if(idx == repoList.count){
                Swift.print("🏁🏁🏁 All repos are now AutoSync'ed")//now go and read commits to list
                onComplete()//🚪➡️️ Exits here
            }
        }
        func onCommitComplete(_ idx:Int, _ hasCommited:Bool){
            //Swift.print("🔨 AutoSync.onCommitComplete() hasCommited: " + "\(hasCommited ? "✅" : "🚫")")
            GitSync.initPush(repoList,idx,onPushComplete)
        }
        for i in repoList.indices{/*all the initCommit calls are non-waiting. */
            GitSync.initCommit(repoList,i,onCommitComplete)//🚪⬅️️ Enter the AutoSync process here
        }
    }
}
