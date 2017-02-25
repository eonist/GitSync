import Foundation
@testable import Utils

class AutoSync {
    static var onComplete:()->Void = {print("⚠️️⚠️️⚠️️ AutoSync.sync() completed but no onComplete is currently attached")}
    /**
     * The GitSync automation algo (Basically Commits and pushes)
     */
    static func sync(){
        let repoXML = FileParser.xml(RepoView.repoList.tildePath)//TODO: this should be cached
        let arr:[Any] = XMLParser.arr(repoXML)
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        /*
         Swift.print("flatArr.count: " + "\(flatArr.count)")
         flatArr.forEach{
         Swift.print("$0: " + "\($0)")
         }
         */
        let repoList:[RepoItem] = flatArr.filter{
            ($0["hasChildren"] == nil) && ($0["isOpen"] == nil)//skip folders
            }.map{(localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)}
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
            repoXML = RepoView.node!.xml
        }else{
            repoXML = FileParser.xml(RepoView.repoList.tildePath)
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
                (localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)
        }
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        return repoList
    }
}
