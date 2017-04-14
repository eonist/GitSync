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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Swift.print("GitSync - Automates git")//Simple git automation for macOS, The autonomouse git client,The future is automated
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //initApp()
        initTestWin()//🚧👷
    }
    func initApp(){
        fileWatcher = FileWatcher(["~/Desktop/ElCapitan/".tildePath])/*<--⚠️️ the fileWatcher instance must be scoped to your class ⚠️️*/
        
        fileWatcher!.event = { /*[weak self]*/ event in//<--The weak self part enables you to interact with your app in a safe manner, not required
            //Swift.print(self.someVariable)//Outputs: a variable in your current class
            Swift.print(event.description)//Outputs: a description of the file change
        }
        
        
        /* StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
         win = MainWin(MainView.w,MainView.h)
         //win = ConflictDialogWin(380,400)
         //win = CommitDialogWin(400,356)
         fileWatcher = StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)*/
    }
    func initTestWin(){
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",false)
        win = TestWin(500,400)/*Debugging Different List components*/
        //fileWatcher = StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            _ = FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, PrefsView.xml.xmlString)
            Swift.print("💾 Write PrefsView to: prefs.xml")
        }
        Swift.print("💾 Write RepoList to: repo.xml")
        _ = FileModifier.write(RepoView.repoListFilePath.tildePath, RepoView.node.xml.xmlString)/*store the repo xml*/
        print("Good-bye")
    }
}
