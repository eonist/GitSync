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
        
//        calcTest()
        
        initApp()
        //testFloating()
        //testTextFloating()
    }
    /**
     *
     */
    func testTextFloating(){
        window.contentView = InteractiveView2()
        
        //var css:String = "Text{fill:blue;float:left;clear:none;}Element#b{fill:red;}Element#c{fill:green;clear:left;}"
        //css +=
        
        let css:String = "" +
        "Section{fill:silver;padding:12px;}" +
        "Text#b{fill:red;}Text#c{fill:green;clear:left;}" +
        "Text{" +
        "float:left;" +
        "clear:none;" +
        "size:12px;" +
        "align:left;" +
        "type:dynamic;" +
        "color:grey6;" +
        "selectable:false;" +
        "wordWrap:true;" +
        "}"
        
        StyleManager.addStyle(css)
        
        let section = window.contentView!.addSubView(Section(400,200))
        
        let a:Text = section.addSubView(Text(100,24,"This is text a: ",section,"a"))
        let b:Text = section.addSubView(Text(100,24,"This is text b: ",section,"b"))
        let c:Text = section.addSubView(Text(100,24,"This is text c: ",section,"c"))
        a.setText("testing testing")
    }
    func testFloating(){
       
        window.contentView = InteractiveView2()
        
        var css:String = "Element{fill:blue;float:left;clear:none;}Element#b{fill:red;}Element#c{fill:green;clear:left;}"
        css += "Section{fill:silver;padding:12px;}"
        StyleManager.addStyle(css)
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url: styleFilePath,liveEdit: false)
        
        let section = window.contentView!.addSubView(Section(400,200))
        //3 Elements
        section.addSubview(Element(50,50,section,"a"))
        let b = section.addSubView(Element(50,50,section,"b"))
        let c = section.addSubView(Element(50,50,section,"c"))
        b.setSize(100, 100)
        //figure it out
    }
    
    func calcTest(){
        window.contentView = InteractiveView2()
//        var css:String = "#btn{fill:blue;width:calc(100% -20px);height:50;float:left;clear:left;}"
//        css += "Section{fill:silver;padding:12px;}"
//        StyleManager.addStyle(css)
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        
        let section = window.contentView!.addSubView(Section(400,200))
//        let btn = section.addSubView(Element(NaN,NaN,section,"btn"))
        
//        section.addSubview(btn)
        
//        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "textInputCard"))
        
        
        
//        StyleManager.addStyle("TextInput#special{fill:blue;fill-alpha:1;width:100%;height:32px;}TextInput#special Text{width:140px;}TextInput#special TextArea{width:calc(100% -140px);}")
        let textInput:TextInput = section.addSubView(TextInput(100, 24, "Description: ", "blue", section,"special"))
        _ = textInput
        Swift.print("before setText")
        textInput.setInputText("test")
        Swift.print("after setText")
    }
    
    /**
     * Initializes the app
     */
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        NSUserNotificationCenter.default.delegate = self//Enables notifications even when app is in focus
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
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
extension AppDelegate:NSUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}
