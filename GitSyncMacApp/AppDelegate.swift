import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac
/**
 * This is the main class for the application
 * TODO: An idea is to hide parts of the interface when the mouse is not over the app (anim in and out) (maybe)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    var timer:SimpleTimer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Swift.print("GitSync - The future is automated")//Simple git automation for macOS, The autonomouse git client
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        //_ = Test2()
        //rateOfCommitsTest()
     
        //initApp()
        
        //Continue: Figure out concurrent threads, check your research
        
        //initTestWin()
        //AutoSync.sync()
        //refreshReposTest()
        
        
    }
    /**
     *
     */
    func doWork(){
        print("working: ")
    }
    /**
     * CommitCount per day for all projects in the last 7 days.
     */
    func rateOfCommitsTest(){
        var result:[Int] = [0,0,0,0,0,0,0]//7 items
        var repoList:[RepoItem] = RepoUtils.repoList//.filter{$0.title == "GitSync - macOS"}
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList = repoList.removeDups({$0.remotePath == $1.remotePath && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
        Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
        var repoCommits:[[CommitCountWork]] = rateOfCommits(repoList)
        var totCount:Int = repoCommits.flatMap{$0}.count

        var idx:Int = 0
        func onComplete(){
            idx += 1
            //Swift.print("onComplete: " + "\(i)")
            if(idx == totCount){
                Swift.print("all concurrent tasks completed")
                /*loop 3d-structure*/
                for i in repoCommits.indices{
                    for e in repoCommits[i].indices{
                        result[i] = result[i] + repoCommits[i][e].commitCount
                    }
                }
                Swift.print("result: " + "\(result)")
            }
        }
        
        /*Loop 3d-structure*/
        for i in repoCommits.indices{
            for e in repoCommits[i].indices{
                bgQueue.async {
                    let work:CommitCountWork = repoCommits[i][e]
                    let commitCount:String = GitUtils.commitCount(work.localPath, work.since , work.until)
                    mainQueue.async {
                        repoCommits[i][e].commitCount = commitCount.int
                        onComplete()
                    }
                }
            }
        }
    }
    /**
     * Returns an array with with week summaries of commit counts from PARAM: repoList
     */
    func rateOfCommits(_ repoList:[RepoItem] )->[[CommitCountWork]]{
        var repoCommits:[[CommitCountWork]] = []
        repoList.forEach{
            let commits:[CommitCountWork] = rateOfCommits($0)
            _ = repoCommits += commits
        }
        
        return repoCommits
    }
    /**
     * Returns an commitCount for 7 days in an Array of 7 Int from PARAM: repoItem
     */
    typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
    func rateOfCommits(_ repoItem:RepoItem) -> [CommitCountWork]{
        Swift.print("repoItem.title: \(repoItem.title) localPath: \(repoItem.localPath)")
        //var commits:[Int] = []
        var commitCountWorks:[CommitCountWork] = []
        for i in (1...7).reversed(){//7 days
            let dayOffset:Int = -i
            let sinceDate:Date = Date().offsetByDays(dayOffset)
            let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
            let untilDate:Date = Date().offsetByDays(dayOffset+1)
            let untilGitDate:String = GitDateUtils.gitTime(untilDate)
            let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
            commitCountWorks.append(comitCountWork)
            //let commitCount:String = GitUtils.commitCount(repoItem.localPath, since: , until:)
            //Swift.print("commitCount: " + "\(commitCount)")
            //commits.append(commitCount.int)
        }
        //Swift.print("commits: " + "\(commits)")
        return commitCountWorks
    }
    /**
     *
     */
    func refreshReposTest(){
        func onComplete(){
            Swift.print("🏆🏆🏆 CommitDB finished!!! ")
        }
        CommitDPRefresher.commitDP = CommitDPCache.read()
        CommitDPRefresher.onComplete = onComplete
        CommitDPRefresher.refresh()
    }
    func initTestWin(){
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",false)
        win = ListTransitionTestWin(600,400)/*Debugging Different List components*/
        
        let url:String = "~/Desktop/ElCapitan/"
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            if(event.fileChange && FilePathParser.fileExtension(event.path) == "css") {//assert for .css file changes, so that .ds etc doesnt trigger events etc
                Swift.print(event.description)
                Swift.print("update to the file happened: " + "\(event.path)")
                StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)
                let view:NSView = self.win!.contentView!//MainWin.mainView!
                ElementModifier.refreshSkin(view as! IElement)
                ElementModifier.floatChildren(view)
            }
        }
        fileWatcher!.start()
    }
    func initApp(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",false)//<--toggle this bool for live refresh
        win = MainWin(MainView.w,MainView.h)
        //win = ConflictDialogWin(380,400)
        //win = CommitDialogWin(400,356)
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
            xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
            xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
            xml.appendChild("<uiSounds>\(String(PrefsView.uiSounds!))</uiSounds>".xml)
            _ = FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, xml.xmlString)
        }
        //store the repo xml
        
        if(RepoView.node != nil){//make sure the data has been read and written to first
            _ = FileModifier.write(RepoView.repoList.tildePath, RepoView.node!.xml.xmlString)
            //Swift.print("RepoList was saved")
        }
        print("Good-bye")
    }
}


