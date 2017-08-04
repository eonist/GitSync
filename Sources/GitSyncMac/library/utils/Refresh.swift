import Foundation
@testable import Utils

typealias CommitDPRefresher = Refresh//temp
/**
 * Basically creates/updates a list of the latest commits
 */
class Refresh{
    typealias RefreshComplete = ()->Void
    var commitDP:CommitDP?
    var startTime:NSDate?/*Debugging*/
    var onAllRefreshComplete:RefreshComplete = {fatalError("Must attach onComplete handler")}/*When all repos has refreshed this method signature is called*/
    init(_ commitDP:CommitDP){
        self.commitDP = commitDP
    }
    /**
     * Inits the refresh process
     */
    func initRefresh(){
        Swift.print("🔄 Refresh.initRefresh() ")
        startTime = NSDate()/*Measure the time of the refresh*/
        refreshRepos()//🚪⬅️️Enter refresh process here
    }
    /**
     * Adds commits to CommitDB
     * NOTE: This method is called from the freshness onComplete
     */
    private func refreshRepos(/*_ sortableRepoList:[FreshnessItem]*/){
        let repos:[RepoItem] = RepoUtils.repoListFlattenedOverridden/*creates array from xml or cache*/
        repos.forEach{
            Swift.print("$0.title: " + "\($0.title)")
        }
        var idx:Int = 0
        func onComplete(){/*TODO: ⚠️️ You can probably use DispatchGroup here aswell. but in the spirit of moving on*/
            idx += 1
            Swift.print("refreshRepo.onComplete() i: \(idx) of: \(repos.count)")
            if idx == repos.count {
                allRefreshesCompleted()
            }
        }
        repos.forEach { repo in
            RefreshUtils.refreshRepo(self.commitDP!,repo,onComplete)//🚪⬅️️ 🚧 0~1000's of a-sync 💼->🐚->🌵 calls
        }
    }
    /**
     * The final complete call
     */
    private func allRefreshesCompleted(){/*All repo items are now refreshed, the entire refresh process is finished*/
        //Swift.print("commitDB.sortedArr.count: " + "\(commitDP!.items.count)")
        //Swift.print("Printing sortedArr after refresh: ")
        //commitDP!.items.forEach{
        //Swift.print("hash: \($0["hash"]!) date: \(GitDateUtils.gitTime($0["sortableDate"]!)) repo: \($0["repo-name"]!) ")
        //}
        CommitDPCache.write(commitDP!)//write data to disk, we could also do this on app exit
        //Swift.print("💾 Refresh.onRefreshReposComplete() Written to disk")
        //isRefreshing = false
        Swift.print("🔄 Refresh.allRefreshesCompleted() ⏰ Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        onAllRefreshComplete()/*🚪➡️️  Calls a dynamic onComplete method, other classes can override this variable to get callback*/
    }
}
class RefreshUtils{
    /**
     * Adds commit items to CommitDB if they are newer than the oldest commit in CommitDB
     * Retrieve the commit log items for this repo with the range specified
     */
    static func refreshRepo(_ dp:CommitDP,_ repo:RepoItem,_ onComplete:@escaping ()->Void){
        Swift.print("RefreshUtils.refreshRepo")
        func onCommitItemsCompleted(_ results:[String]){
            Swift.print("🍌🍌🍌 Refresh.swift RefreshUtils.onCommitItemsCompleted(): \(repo.title) results.count: \(results.count)" )
            results.forEach { result in
//                Swift.print("result: " + "\(result.count)")
                if result.count > 0 {/*resulting string must have characters*/
                    let commitData:CommitData = CommitData.conform(result)/*Compartmentalizes the result into a Tuple*/
//                    Swift.print("commitData: " + "\(commitData)")
                    //let commit:Commit = CommitViewUtils.processCommitData(repoTitle,commitData,0)/*Format the data*/
//                    Swift.print("repo.title: " + "\(repo.title)")
                    let commitDict:[String:String] = CommitViewUtils.processCommitData(repo.title, commitData)
                    dp.addCommitItem(commitDict)/* 🏁 add the commit log items to the CommitDB*/
                }else{
                    //Swift.print("RefreshUtils.refreshRepo() ERROR: repo: \(repo.title) at result index: \(i) didn't have any characters")
                }
            }//if results.count == 0 then -> no commitItems to append (because they where to old or non existed)
            onComplete()/*🚪➡️️*/
        }
        func onCommitCountComplete(_ commitCount:Int){/*once these completes then do result, you do not want to wait until calling refreshRepo*/
            Swift.print("💙 RefreshUtils.refreshRepo() \(repo.title): commitCount: " + "\(commitCount)")
            RefreshUtils.commitItems(repo.local, commitCount, onCommitItemsCompleted)//🚧0~100 Git calls/*creates an array raw commit item logs, from repo*/
        }
        commitCount(dp,repo,onCommitCountComplete)//🚪⬅️️
    }
    /**
     * Find the range of commits to add to CommitDB for this repo
     */
    private static func commitCount(_ dp:CommitDP,_ repo:RepoItem, _ onComplete:@escaping (_ commitCount:Int)->Void) {
        Swift.print("RefreshUtils.commitCount()")
        var commitCount:Int = 0
        var totCommitCount:Int = 0
        let group = DispatchGroup()
        group.notify(queue: main){
            let clippedCommitCount = Swift.min(totCommitCount,commitCount)
            onComplete(clippedCommitCount)/*🚪➡️️*/
        }
        
        bg.async {/*do some work in the background*/
            group.enter()
            totCommitCount = GitUtils.commitCount(repo.local).int - 1//🚧1 Git call/*Get the total commitCount of this repo*/
            group.leave()
        }
        
        bg.async {/*maybe do some work*/
            group.enter()
            if(dp.items.count > 0){
                let lastDate:Int = dp.items.last!["sortableDate"]!.int/*the last date is always the furthest distant date 19:59,19:15,19:00 etc*/
                let gitTime = GitDateUtils.gitTime(lastDate.string)/*converts descending date to git time*/
                let rangeCount:Int = GitUtils.commitCount(repo.local, after: gitTime).int//🚧1 Git call /*Finds the num of commits from now until */
                commitCount = min(rangeCount,100)/*force the value to be no more than max allowed*/
            }else {//< 100
                commitCount = (100)//You need to top up dp with 100 if dp.count = 0, ⚠️️ this works because later this value is cliped to max of repo.commits.count
            }
            group.leave()
        }
    }
    static var totalCommitCount:Int = 0
    static var commitCount:Int = 0
    static var commitsCompletedCount:Int = 0
    
    /**
     * Basically creates an array of commit data from the latest commit until limit (limit:3 returns the 3 last commits)
     * Returns an array of commitItems at PARAM: localPath and limited with PARAM: max
     * PARAM: limit = max Items Allowed per repo
     */
    static func commitItems(_ localPath:String,_ limit:Int, _ onComplete:@escaping (_ results:[String])->Void) {
        Swift.print("RefreshUtils.commitItems()")
        var results:[String] = Array(repeating: "", count:limit)//basically creates an array with many empty strings
        let group = DispatchGroup()
        group.notify(queue: main){
            //Swift.print("🏁 Utils.commitItems() all results completed results.count: \(results.count)")
            Swift.print("🏁 group completed. results: " + "\(results.count)")
            onComplete(results.reversed()) //reversed is a temp fix/*Jump back on the main thread bc: onComplete resides there*/
        }
        let formating:String = "--pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b".encode()!//"-3 --oneline"//
        totalCommitCount += limit
        Swift.print("totalCommitCount: " + "\(totalCommitCount)")
        for i in 0..<limit{
            commitCount += 1
            group.enter()
            bg.async{/*inner*/
                let cmd:String = "head~" + "\(i) " + formating + " --no-patch"
                let result:String = GitParser.show(localPath, cmd)//🚧 git call//--no-patch suppresses the diff output of git show
//                Swift.print("result: " + "\(result.count)")
                main.async {
//                    Swift.print("result main: " + "\(result.count)")
                    results[i] = result//results.append(result)
                    group.leave()
                }
            }
        }
        if limit == 0 {onComplete([])}//if there was nothing to process just return, TODO: ⚠️️ should be handled by called really
    }
}
