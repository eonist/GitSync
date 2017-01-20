import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide parts of the interface when the mouse is not over the app (anim in and out) (maybe)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    var test:PopulateCommitDB?
    var timer:Timer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
         Swift.print("GitSync - Simple git automation for macOS")
         NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
         
         //_ = Test()
         //initApp()
         //initTestWin()
         //_ = PopulateCommitDB()
         
         Swift.print(ArrayAsserter.equals(["",""], ["","",""]))//false
         Swift.print(ArrayAsserter.equals([1,2], [1,2]))//true
         /**/
    }
    func initTestWin(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        win = ListTransitionTestWin(600,400)
        
        /*let url:String = "~/Desktop/ElCapitan/explorer.css"
         fileWatcher = FileWatcher([url.tildePath])
         fileWatcher!.event = { event in
         //Swift.print(self)
         Swift.print(event.description)
         if(event.fileChange && event.path == url.tildePath) {
         Swift.print("update to the file happened")
         StyleManager.addStylesByURL(url,true)
         let view:NSView = self.win!.contentView!//MainWin.mainView!
         ElementModifier.refreshSkin(view as! IElement)
         ElementModifier.floatChildren(view)
         }
         }
         fileWatcher!.start()*/
    }
    func initApp(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        
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
        if(RepoView.dp != nil){//make sure the data has been read and written to first
            _ = FileModifier.write("~/Desktop/assets/xml/list.xml".tildePath, RepoView.dp!.xml.xmlString)
        }
        print("Good-bye")
    }
}
