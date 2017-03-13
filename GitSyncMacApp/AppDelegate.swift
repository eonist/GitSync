import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac
/**
 * This is the main class for the application
 * Not one error in a million keystrokes
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    //var timer:SimpleTimer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Swift.print("GitSync - The future is automated")//Simple git automation for macOS, The autonomouse git client
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        //_ = Test2()
        
        //rateOfCommitsTest()
        
        initApp()
        
        //Continue here:🏀
            //think about it differently: disabled:true-> means children dont AutoSync, disabled:false or no disable attriv -> Children decide their own disabledness
        
        
        //_ = ASyncTest()
        //_ = AsyncTest2()
        
        //initTestWin()🔨
        //AutoSync.sync()
        //refreshReposTest()
        
        /*let xStr1:String = "<items>"
        let xStr2:String = 	"<item title=\"John\" color=\"blue\" value=\"003300\">"
        let xStr3:String = 		"<item title=\"Ben\" color=\"orange\" value=\"001122\">"
        let xStr4:String = 			"<item title=\"John\" color=\"blue\" value=\"003300\"></item>"
        let xStr5:String = 			"<item title=\"John\" color=\"blue\" value=\"003300\"></item>"
        let xStr6:String = 		"</item>"
        let xStr7:String = 	"</item>"
        let xStr8:String = "</items>"
        
        let xml:XML = (xStr1 + xStr2 + xStr3 + xStr4 + xStr5 + xStr6 + xStr7 + xStr8).xml
        let a = XMLParser.arr(xml)
        Swift.print("a: " + "\(a)")*/
        
        //let repoList = RepoUtils.repoListFlattenedOverridden
        //Swift.print(repoList)
        
        // it works, now activate this in a filter, if active is false then dont return repo, easy! test it first, then test gitpull 
    }
    /**
     * CommitCount per day for all projects in the last 7 days where the user is "eonist"
     */
    func rateOfCommitsTest(){
        let rateOfCommits = RateOfCommits()
        func onComplete(_ results:[Int]){
            Swift.print("Appdelegate.onComplete()")
            Swift.print("results.count: " + "\(results.count)")
        }
        rateOfCommits.onComplete = onComplete
        rateOfCommits.initRateOfCommitsProcess(0)
    }
    /**
     *
     */
    func refreshReposTest(){
        func onComplete(){
            Swift.print("🏆🏆🏆 CommitDB finished!!! ")
        }
        //CommitDPRefresher.commitDP = CommitDPCache.read()
        //CommitDPRefresher.onComplete = onComplete
        //CommitDPRefresher.refresh()
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
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        win = MainWin(MainView.w,MainView.h)
        //win = ConflictDialogWin(380,400)
        //win = CommitDialogWin(400,356)
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
    func applicationWillTerminate(_ aNotification: Notification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
            xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
            xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
            xml.appendChild("<uiSounds>\(String(PrefsView.uiSounds!))</uiSounds>".xml)
            _ = FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, xml.xmlString)
            Swift.print("💾 Write PrefsView to: prefs.xml")
        }
        Swift.print("💾 Write RepoList to: repo.xml")
        //Swift.print("RepoView.node.xml.xmlString: " + "\(RepoView.node.xml.xmlString)")
        _ = FileModifier.write(RepoView.repoListFilePath.tildePath, RepoView.node.xml.xmlString)/*store the repo xml*/
        print("Good-bye")
    }
}
