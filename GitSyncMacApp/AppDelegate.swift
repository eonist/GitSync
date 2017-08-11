import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

/**
 * This is the main class for the application
 * Not one error in a million keystrokes
 */
@NSApplicationMain
class AppDelegate:NSObject, NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var menu:Menu?//TODO: ⚠️️ make lazy. does it need to be scoped globally?
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Swift.print("GitSync - Automates git")
//        initApp()
        
        FileModifier.delete("~/dev/demo2".tildePath)
        
        let status = GitModifier.clone("https://github.com/gitsync/demo2.git","~/dev/demo2".tildePath)
//        FileModifier.delete(gitURL)
//        AutoInit.autoInit("~/dev/welcome/".tildePath, remotePath: "github.com/gitsync/welcome.git", branch: "master")
        
        //Continue here: 🏀
            //There is a problem where repos are not pulled. Fetch is never being called on each autoSync. test this again✅
        
            //The autosync on interval
                //stop on pull gesture init 🚫
                //start after pull gesture completes etc
        
            //Add Auto init
                //auto fill local path
                //design UX for stashing / remove preexisting files / merge into
                    //setup the scenarios ✅
                    //test the scenarios 👈
                //center the wizard text in the dialogs
        
            //add filepicker prompt
                //needs filepicker UI
        
            //Make RepoDetail store date to disk on View.close()
                //add a Closable protocol 
                //add removeSelf and save to repo.xml for RepoDetail and PrefsView

    }
    
    /**
     * Initializes the app
     */
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        Swift.print("styleFilePath: " + "\(styleFilePath)")
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        win = StyleTestWin(PrefsView.prefs.rect.w, PrefsView.prefs.rect.h)
        
        menu = Menu()/*This creates the App menu*/
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.Bundle.prefs.tildePath, PrefsView.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}
