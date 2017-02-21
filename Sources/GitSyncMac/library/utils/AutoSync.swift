import Foundation
@testable import Utils

class AutoSync {
    /**
     * The GitSync automation algo
     */
    static func initCommitPush(){
        let repoXML = FileParser.xml(RepoView.repoList.tildePath)
        let repoList:[RepoItem] = XMLParser.toArray(repoXML).map{(localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)}
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        var idx:Int = 0
        
        func onCommitComplete(_ hasCommited:Bool){
            Swift.print("🍊 AppDelegate.onCommitComplete() hasCommited: " + "\(hasCommited)")
            GitSync.initPush(repoList[idx])
        }
        func onPushComplete(_ hasPushed:Bool){
            Swift.print("🍏 AppDelegate.onPushComplete() hasPushed: " + "\(hasPushed)")
            idx += 1
            if(idx < repoList.count){
                GitSync.initCommit(repoList[idx])//👈 iterate repo items
            }else{
                Swift.print("🏁🏁🏁 All repos are complete")//now read commits to list
            }
        }
        GitSync.onPushComplete = onPushComplete/*Attach eventHandler*/
        GitSync.onCommitComplete = onCommitComplete/*Attach eventHandler*/
        if(repoList.count > 0){
            GitSync.initCommit(repoList[idx])//👈init the loop
        }
    }
}
