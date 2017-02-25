import Foundation
@testable import Utils

class AutoSync {
    static var onComplete:()->Void = {print("⚠️️⚠️️⚠️️ AutoSync.sync() completed but no onComplete is currently attached")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func sync(){
        let repoList:[RepoItem] = self.repoList
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
                onComplete()
            }
        }
        GitSync.onPushComplete = onPushComplete/*Attach eventHandler*/
        GitSync.onCommitComplete = onCommitComplete/*Attach eventHandler*/
        if(repoList.count > 0){
            GitSync.initCommit(repoList[idx])//👈init the loop
        }
    }
}
extension AutoSync{
    /**
     * Returns an array of RepoItems derived from a nested xml Structure
     */
    var repoList:[RepoItem]{
        let repoXML:XML
        if(RepoView.node != nil){
            repoXML = RepoView.node!.xml//re-use if it already exists
        }else{
            repoXML = FileParser.xml(RepoView.repoList.tildePath)//or load a fresh copy
        }
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        /*
         Swift.print("flatArr.count: " + "\(flatArr.count)")
         flatArr.forEach{
         Swift.print("$0: " + "\($0)")
         }
         */
        let repoList:[RepoItem] = flatArr.filter{
            ($0["hasChildren"] == nil) && ($0["isOpen"] == nil)//skips folders
            }.map{//create array of tuples
                AutoSync.repoItem($0)
        }
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        return repoList
    }
    /**
     *
     */
    static func repoItem(_ dict:[String:String]) -> RepoItem{
        return (localPath:dict["local-path"]!,interval:dict["interval"]!.int,branch:dict["branch"]!,keyChainItemName:dict["keychain-item-name"]!,broadcast:dict["broadcast"]!.bool,title:dict["title"]!,subscribe:dict["subscribe"]!.bool,autoSync:dict["auto-sync"]!.bool,remotePath:dict["remote-path"]!)
    }
}
