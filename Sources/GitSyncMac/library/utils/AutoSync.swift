import Foundation
@testable import Utils

class AutoSync {
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func sync(_ onComplete:@escaping ()->Void){
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
        
        
        for i in repoList.indices{
            let repoItem = repoList[i]
            GitSync.initCommit(repoList[idx],onCommitComplete)//🚪⬅️️ starts the AutoSync process
        }
        
    }
}
