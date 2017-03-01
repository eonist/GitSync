import Foundation
@testable import Utils

class AutoSync {
    static var onComplete:()->Void = {print("⚠️️⚠️️⚠️️ AutoSync.sync() completed but no onComplete is currently attached")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func sync(){
        let repoList:[RepoItem] = RepoUtils.repoList
        var idx:Int = 0
        
        func onCommitComplete(_ hasCommited:Bool){
            Swift.print("🍊 AppDelegate.onCommitComplete() hasCommited: " + "\(hasCommited)")
            GitSync.initPush(repoList[idx])
        }
        func onPushComplete(_ hasPushed:Bool){
            Swift.print("🍏 AppDelegate.onPushComplete() hasPushed: " + "\(hasPushed)")
            idx += 1
            if(idx < repoList.count){
                GitSync.initCommit(repoList[idx],onCommitComplete)//👈 iterate repo items
            }else{
                Swift.print("🏁🏁🏁 All repos are complete")//now read commits to list
                onComplete()
            }
        }
        GitSync.onPushComplete = onPushComplete/*Attach eventHandler*/
        if(repoList.count > 0){
            GitSync.initCommit(repoList[idx],onCommitComplete)//🚪⬅️️ starts the AutoSync process
        }
    }
}
