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
        //initTestWin()
        //AutoSync.sync()
        //refreshReposTest()
        /*let a:Range<Int> = 0..<10
         let b:Range<Int> = 10..<15
         let diff = RangeParser.difference(a, b)
         Swift.print("diff: " + "\(diff)")*/
        
        var xmlStr = "<items>"
        xmlStr += "<item title=\"orange\" property=\"harry\"/>"
        xmlStr += "<items>"
        xmlStr += "<item title=\"blueberry\" property=\"John\"/>"
        xmlStr += "</items>"
        xmlStr += "<item title=\"blue\" property=\"na\"/>"
        xmlStr += "</items>"
        
        let arr:[Any] = [["a"],[["b","c"],"d"]]//XMLParser.arr(xmlStr.xml)//[0,[1],[[2],[3]]]
    
        /**
         *
         */
        func recFlatMap<T>(_ arr:[AnyObject]) -> [T]{
            var result:[T] = []
            Swift.print("arr.count: " + "\(arr.count)")
            for i in 0..<arr.count{
                let item:AnyObject = arr[i]
                Swift.print("item: " + "\(item)")
                if(item is AnyArray){
                    Swift.print("is AnyArray")
                    let a:[AnyObject] = item as! [AnyObject]
                    result += recFlatMap(a)
                }else{
                    result.append(arr[i] as! T)
                }
            }
            return result
        }
        let flatArr:[String] = recFlatMap(arr as [AnyObject])
        Swift.print("flatArr.count: " + "\(flatArr.count)")
        Swift.print("flatArr: " + "\(flatArr)")
        /*
         
         Swift.print("arr: " + "\(arr)")
         Swift.print("arr.count: " + "\(arr.count)")
         Swift.print("arr[1].count: " + "\(arr[1].count)")
         */
        
        //let arr:[Any] = [[[1],[2,3]],[[4,5],[6]]]
                
        //let x2:[Int] = arr.recursiveFlatmap()
        //Swift.print(x2)
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
extension Collection {
    func recursiveFlatmap<T>() -> [T] {
        var results = [T]()
        for element in self {
            if let sublist = element as? [Self.Generator.Element] {
                results += sublist.recursiveFlatmap()
            } else if let element = element as? T {
                results.append(element)
            }
        }
        
        return results
    }
}

