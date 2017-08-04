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
        
        //Continue here: 🏀
            //make animation idea: circle with graphbar, circle with 3 dots animating indicating sync, circle with tree list repo, 
            //fix no showing commits ✅
            //Get rid of typealias data containers and start using structs. also get rid of dictionary data containers 
            //clean up async code
                //try with the mini libs
            //fix > arrow in repo
            //use relative paths for .swift files ✅
            //write the clone into algo (find old uml, and old applescript code)
            //design the new UI mockups 👈
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
        let styleFilePath:String = Config.Bundle.assets + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        win = StyleTestWin(PrefsView.prefs.rect.w, PrefsView.prefs.rect.h)/*⬅️️🚪*/
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
