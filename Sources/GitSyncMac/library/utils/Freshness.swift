import Foundation

class Freshness {
    var onFreshnessSortComplete:()->Void = {print("⚠️️⚠️️⚠️️ Commit refresh completed but no onComplete is currently attached")}
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
     * PARAM: repoFilePath: the the repo file contains info about each repo to sort.
     */
    func freshnessSort(_ repoFilePath:String){
        Swift.print("💜 freshnessSort()")
        var sortableRepoList:[(repo:RepoItem,freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
        async(bgQueue, { () -> Void in//run the task on a background thread
            let repoXML = FileParser.xml(repoFilePath.tildePath)//~/Desktop/repo2.xml
            let repoList:[RepoItem] = XMLParser.toArray(repoXML).map{(localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)}
            repoList.forEach{/*sort the repoList based on freshness*/
                let freshness:CGFloat = Utils.freshness($0.localPath)
                sortableRepoList.append(($0,freshness))
            }
            sortableRepoList.sort(by: {$0.freshness > $1.freshness})/*sorts repos according to freshness, the freshest first the least fresh at the botom*/
            async(mainQueue){/*Jump back on the main thread*/
                self.onFreshnessSortComplete(sortableRepoList)
            }
        })
    }
    /**
     * Freshness level of every repo is calculated
     */
    func onFreshnessSortComplete(_ sortableRepoList:[(repo:RepoItem,freshness:CGFloat)]){
        //sortableRepoList.forEach{Swift.print($0.repo["title"]!)}
        Swift.print("💛 onFreshnessSortComplete() Time:-> " + "\(abs(CommitDPRefresher.startTime!.timeIntervalSinceNow))")/*How long it took*/
        CommitDPRefresher.refreshRepos(sortableRepoList)
    }
}
