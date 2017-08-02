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
//        initApp()
        
//        Swift.print("FilePathParser.resourcePath: " + "\(FilePathParser.resourcePath)")
//        Swift.print("Config.Bundle.repo: " + "\(Config.Bundle.repo)")
//        Swift.print("Config.Bundle.repo.content: " + "\(Config.Bundle.repo.content)")
    
        //Swift.print(FilePathModifier.normalize(FilePathParser.resourcePath + "/../"))
        //../../folderA/folder4/graphic.svg
        //~/
        //folderA/folderB/graphic.svg
        
        //Continue here: 🏀 
            //take a look at URL patterns
            //(../)*? or (/\\w*?)
            //your essentially making relativeURLPattern
        
//        let svgFileName:String = "\\b.*.svg\\z"
        let string = "abc /styles/star.svg white"
        let result = string.replace("(?=[,: ]?)[\\w/~]+.svg", "x")
        Swift.print("result: " + "\(result)")
        
        
    }
    /**
     * It's all about making UI / UX dribbble style !
     */
        func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.assets + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
//        let rect:CGRect = PrefsView.prefs.rect
//        win = StyleTestWin(rect.w, rect.h)/*⬅️️🚪*/
//        menu = Menu()/*This creates the App menu*/
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.Bundle.prefs.tildePath, PrefsView.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}
