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
      
//        let arrIterator = ArrayIterator(array:[1,2,3,4,5])
//        while arrIterator.hasNext() {
//            Swift.print(arrIterator.next())
//        }
        
        initApp()
//
        //quickTest()
//        quickTest2()
//        quickTest3()
    }
    /**
     *
     */
    func quickTest3(){
        //Continue here: 🏀
        //create 1 button
        StyleManager.addStyle("Button{fill:green;}")
        window.contentView = InteractiveView()
        let section = window.contentView?.addSubView(Section(200,200))
        let btn = section?.addSubView(Button.init(size: CGSize(100,100)))
        _ = btn
            //test state
        //create 2 buttons
            //test state
        //create 2 SelectButtons
            //test state etc
    }
    /**
     *
     */
    func quickTest2(){
         window.contentView = InteractiveView()
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        
//        StyleManager.addStylesByURL("~/Desktop/ElCapitan/general.css",false)
//        StyleManager.addStyle("List{fill:blue;}")
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        
//        let list = List4.init(size:CGSize(140,73),id:nil)
        let section = window.contentView?.addSubView(Section(size:CGSize(200,200)))
        let list = List3.init(140, 73, CGSize(120,24), dp,.ver)
        Swift.print("y")
        _ = section?.addSubView(list)
        Swift.print("x")
//        list.selectAt(1)
    }
    func quickTest(){
        window.contentView = InteractiveView()

        //var css:String = "Button{fill:blue;float:left;clear:none;}Button#b{fill:red;}Button#c{fill:green;clear:left;}"
        let css:String = """
        TextInput{
            float:left;
            clear:left;
            padding-top:2px;
        }
        TextInput Text{
            float:left;
            clear:none;
            width:78px;
            height:20px;
            color:black;
        }
        TextInput TextArea{
            float:left;
            clear:none;
            width:60px;
            height:20px;
            padding:0px;/*Resets padding from Generic TextArea*/
            padding-left:4px;
            padding-right:4px;
            fill:white;
            line:#A4A4A4;
            line-alpha:1;
            line-thickness:1px;
            line-offset-type:outside;
            /*margin-left:6px;*/
        }
        TextInput TextArea Text{
            backgroundColor:orange;
            background:false;
            type:input;
            selectable:true;
        }
        """
        StyleManager.addStyle(css)
        
        let section = window.contentView!.addSubView(Section(400,200))
        let textInput:TextInput = section.addSubView(TextInput(240, 24, "Description: ", "blue",section))
        _ = textInput
        
//        css += "Section{fill:silver;padding:12px;}"
//        StyleManager.addStyle(css)
//
//
//        let section = window.contentView!.addSubView(Section(400,200))
//        //3 Elements
//        section.addSubview(Button(50,50,section,"a"))
//        let b = section.addSubView(Button(50,50,section,"b"))
//        let c = section.addSubView(Button(50,50,section,"c"))
//        _ = c
//        b.setSize(100, 100)
        //figure it out
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
        _ = FileModifier.write(Config.Bundle.prefsURL.tildePath, PrefsData.xml.xmlString)/*Stores the app prefs*/
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

