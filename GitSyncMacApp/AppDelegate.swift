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
        initApp()
        
//        AutoInit.autoInit("~/dev/welcome/".tildePath, remotePath: "github.com/gitsync/welcome.git", branch: "master")
        
        //Continue here: 🏀
        
            //Hock up the dialog prompts to manualMerge etc 👈
                //trigger the CommitMessagePrompt if repo has message flag disabled ✅
        
            //The autosync on interval 👈
                //auto fill local path
                //design UX for 
        
            //Add Auto init
        
            //add filepicker prompt
                //needs filepicker UI
        
            //Get rid of typealias data containers and start using structs. also get rid of dictionary data containers
        
            //fix > arrow in repo

        
            //design the new UI mockups
            //prototype menu 
                //Research menu micro anims
            //prototype prompt dialog popups
            //prototype view transitions
            //prototype new refresh anim (triple dots)
                //research refresh micro anims (see victor from medium)
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
