import Foundation
@testable import Utils

class AutoSync {
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func sync(_ onComplete:@escaping ()->Void){
        let repoList:[RepoItem] = RepoUtils.repoList
        var idx:Int = 0
        
        func onPushComplete(_ hasPushed:Bool){
            Swift.print("🍏 AppDelegate.onPushComplete() hasPushed: " + "\(hasPushed)")
            idx += 1
            if(idx == repoList.count){
                Swift.print("🏁🏁🏁 All repos are complete")//now go and read commits to list
                onComplete()//🚪➡️️ Exits here
            }
        }
        func onCommitComplete(_ idx:Int, _ hasCommited:Bool){
            Swift.print("🍊 AppDelegate.onCommitComplete() hasCommited: " + "\(hasCommited)")
            GitSync.initPush(repoList,idx,onPushComplete)
        }
        for i in repoList.indices{
            GitSync.initCommit(repoList,i,onCommitComplete)//🚪⬅️️ Enter the AutoSync process here
        }
    }
}
