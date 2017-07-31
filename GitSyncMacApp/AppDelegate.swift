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
        Swift.print("GitSync - Automates git")//Simple git automation for macOS, The autonomouse git client,The future is automated
        //initApp()
        Swift.print("FilePathParser.appDocPath(): " + "\(FilePathParser.appDocPath())")
        let temp = FileParser.content(FilePathParser.appDocPath() + "/test.txt")
        //let temp = FileParser.resourceContent("example","txt")
        Swift.print("temp: " + "\(temp)")
        //Continue here: 🏀 
            //try with out disableAnim 👈
            //Add more types to Easer/Springer ✅
            //try to do a rotation test back and forth with elastic
            //Playground testing
        //add interuptabable animators to the fold
        
        //peekAndPopTest()
    }
    /**
     * It's all about making UI / UX dribbble style !
     */
    func peekAndPopTest(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        win = ProtoTypeWindow(ProtoTypeView.WinRect.size.w,ProtoTypeView.WinRect.size.h)/*⬅️️🚪*/
    }
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
        
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        let rect:CGRect = PrefsView.prefs.rect
        win = StyleTestWin(rect.w, rect.h)/*⬅️️🚪*/
        menu = Menu()/*This creates the App menu*/
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.prefs.tildePath, PrefsView.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.repoListFilePath.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}
