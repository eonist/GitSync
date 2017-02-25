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
        //_ = Test()
        //initApp()
        //recursiveFlatMapTest()
        //flattenNestedXMLTest()
        let array = ["Orange", "Apple", "Apple Juice"]
        let filteredArray = array.filter() {
            return $0.hasPrefix("Apple")
        }
        Swift.print("filteredArray: " + "\(filteredArray)")
        //initTestWin()
        //AutoSync.sync()
        //refreshReposTest()
        /*let a:Range<Int> = 0..<10
         let b:Range<Int> = 10..<15
         let diff = RangeParser.difference(a, b)
         Swift.print("diff: " + "\(diff)")*/
        
    }
    /**
     *
     */
    func flattenNestedXMLTest(){
        let repoXML = FileParser.xml(RepoView.repoList.tildePath)//TODO: this should be cached
        
        //research how you can flatten a 3d array, see if you already have code for this in xmlparser maybe?
        let temp:[Any] = XMLParser.arr(repoXML)
        let flatArr:[[String:String]] = temp.recursiveFlatmap()
        Swift.print("flatArr.count: " + "\(flatArr.count)")
        flatArr.forEach{
            Swift.print("$0: " + "\($0)")
        }
        let repoList:[RepoItem] = flatArr.map{
            (localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)
        }
        Swift.print("repoList.count: " + "\(repoList.count)")
    }
    /**
     *
     */
    func recursiveFlatMapTest(){
        
        var xmlStr = "<items>"
        xmlStr += "<item title=\"orange\" property=\"harry\"/>"
        xmlStr += "<items>"
        xmlStr += "<item title=\"blueberry\" property=\"John\" color=\"blue\"/>"
        xmlStr += "</items>"
        xmlStr += "<item title=\"blue\" property=\"na\"/>"
        xmlStr += "</items>"
        
        //let arr:[Any] = [["title":"a"],[[["title":"b"],["title":"c"]],["title":"d"]]]//
        let arr:[Any] = XMLParser.arr(xmlStr.xml)//[0,[1],[[2],[3]]]
        
        /**
         *
         */
        func recFlatMap<T>(_ arr:[AnyObject]) -> [T]{
            var result:[T] = []
            Swift.print("arr.count: " + "\(arr.count)")
            arr.forEach{
                if($0 is AnyArray){
                    let a:[AnyObject] = $0 as! [AnyObject]
                    result += recFlatMap(a)
                }else{
                    result.append($0 as! T)
                }
            }
            return result
        }
        let flatArr:[[String:String]] = arr.recursiveFlatmap()//recFlatMap(arr as [AnyObject])
        Swift.print("flatArr.count: " + "\(flatArr.count)")
        //Swift.print("flatArr: " + "\(flatArr)")
        flatArr.forEach{
            Swift.print("$0: " + "\($0)")
        }
        
        //Continue here:
            //A problem is that the Dicts get flattened too, figure this out and your set👌
        
        /*
         
         Swift.print("arr: " + "\(arr)")
         Swift.print("arr.count: " + "\(arr.count)")
         Swift.print("arr[1].count: " + "\(arr[1].count)")
         */
        
        //let arr:[Any] = [[[1],[2,3]],[[4,5],[6]]]
        
        //let x2:[Int] = arr.recursiveFlatmap()
        //Swift.print(x2)//1,2,3,4,5,6
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
        }
        print("Good-bye")
    }
}


