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
        
        let frst = first(["a","b","c"], "b", {$0 == $1})
        Swift.print("frst: " + "\(frst)")
        //initApp()
        
        //initTestWin()
        //AutoSync.sync()
        //refreshReposTest()
    }
    /**
     * Example:
     */
    func first<T>(_ arr:[T], _ match:T, _ condition:(_ a:T, _ b:T)->Bool)->T?{
        for item in arr{
            if(condition(item,match)){
                return item
            }
        }
        return nil
    }
    /**
     * CommitCount per day for all projects in the last 7 days.
     */
    func rateOfCommitsTest(){
        let repoList:[RepoItem] = RepoUtils.repoList//.filter{$0.title == "GitSync - macOS"}
        
        
        
        let repoCommits:[[Int]] = rateOfCommits(repoList)
        Swift.print("repoCommits.count: " + "\(repoCommits.count)")
        var result:[Int] = [0,0,0,0,0,0,0]//7 items
        repoCommits.forEach{
            for i in $0.indices{
                result[i] = result[i] + $0[i]
            }
        }
        Swift.print("result: " + "\(result)")
    }
    /**
     * Returns an array with with week summaries of commit counts from PARAM: repoList
     */
    func rateOfCommits(_ repoList:[RepoItem] )->[[Int]]{
        var repoCommits:[[Int]] = []
        repoList.forEach{
            let commits:[Int] = rateOfCommits($0)
            _ = repoCommits += commits
        }
        
        return repoCommits
    }
    /**
     * Returns an commitCount for 7 days in an Array of 7 Int from PARAM: repoItem
     */
    func rateOfCommits(_ repoItem:RepoItem) -> [Int]{
        Swift.print("repoItem.title: \(repoItem.title) localPath: \(repoItem.localPath)")
        var commits:[Int] = []
        for i in (1...7).reversed(){//7 days
            let dayOffset:Int = -i
            let sinceDate:Date = Date().offsetByDays(dayOffset)
            let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
            let untilDate:Date = Date().offsetByDays(dayOffset+1)
            let untilGitDate:String = GitDateUtils.gitTime(untilDate)
            let commitCount:String = GitUtils.commitCount(repoItem.localPath, since: sinceGitDate, until:untilGitDate )
            //Swift.print("commitCount: " + "\(commitCount)")
            commits.append(commitCount.int)
        }
        Swift.print("commits: " + "\(commits)")
        return commits
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


