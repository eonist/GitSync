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
    

//    enum MyError : Error {
//        case RuntimeError(String)
//    }
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Swift.print("GitSync - Automates git")
      
//
        //Continue here: 🏀
            //Add back RepoView
            //figure out why Element is always crashing when attempting to commit
        
        
        initApp()
//
//        quickTest()
//        quickTest2()
//        quickTest3()
//        quickTest5()
//        quickTest6()
        
       
        func test(color:NSColor) throws{
            if color == .red {
                throw "I don't like red"
            }else if color == .green {
                throw "I'm not into green"
            }else {
                throw "I like all other colors"
            }
        }
        
        do {
            try test(color:.green)
        } catch let error where error.localizedDescription == "I don't like red"{
            Swift.print ("Error: \(error)")//"I don't like red"
        }catch let error {
            Swift.print ("Other cases: Error: \(error.localizedDescription)")/*I like all other colors*/
        }
        
        //where error.l == "I like all other colors"
        
        
        //throw "Some Error"//To make the string itself be the localizedString of the error you can instead extend LocalizedError:
        
        
        //
    }
    /**
     *
     */
    func quickTest6(){
        window.contentView = InteractiveView()
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        
        //        StyleManager.addStylesByURL("~/Desktop/ElCapitan/general.css",false)
        //        StyleManager.addStyle("List{fill:blue;}")
        
        //        let list = List4.init(size:CGSize(140,73),id:nil)
        let section = window.contentView?.addSubView(Section(size:CGSize(200,200)))
        
//        _ = section?.addSubView(TextButton.init(text: "Button"))//(NaN,NaN,"Button")
        
        //then try the app 🏀
        
        let radioButton1:RadioButton? = section?.addSubView(RadioButton.init(text: "Option 1", isSelected: true))//80,14,"Option 1",false,section
        _ = radioButton1
    }
    /**
     *
     */
    func quickTest5(){
        let css = """
        Section{
            fill:blue;
            clear:left;
            float:left;
            width:120px;
            height:120px;
        }
        Section#b{
            fill:red;
            width:50%;
            height:50%;
        }
        

        
        """
        StyleManager.addStyle(css)
        window.contentView = InteractiveView()
        //        let text = TextField.editableTextField()
        //        window.contentView?.addSubview(text)
        
        //Continue here: 🏀
        //Caret works if there is size, but not when size is NaN
        let a = window.contentView?.addSubView(Section.init(size:CGSize(0,0)))
        let b = a?.addSubView(Section.init(size:CGSize(0,0),id:"b"))
       
    }
    
    /**
     *
     */
    func quickTest3(){
        //Continue here: 🏀
        //create 1 button
        let css = """
        Section{
            fill:blue;
            clear:left;
            float:left;
            width:220px;
            height:220px;
        }
        Section#b{
            fill:orange;
            fill-alpha:0.5;
        }
        Text{
            width:120px;
            height:24px;
            float:left;
            clear:left;
            font:Helvetica Neue;
            size:12px;
            align:left;
            type:input;
            color:grey6;
            selectable:true;
            wordWrap:true;
        }

        
        """
        StyleManager.addStyle(css)
        window.contentView = InteractiveView()
//        let text = TextField.editableTextField()
//        window.contentView?.addSubview(text)
        
        //Continue here: 🏀
            //Caret works if there is size, but not when size is NaN
        let a = window.contentView?.addSubView(Section.init(size:CGSize(0,0)))
//        let b = a?.addSubView(Section.init(size:CGSize(NaN,NaN),id:"b"))
//        b?.frame.origin = CGPoint(100,100)
        let textTest:Text? = a?.addSubView(Text.init(text: "Hello world"))
//        textTest?.frame.size = CGSize(100,24)
//        textTest?.skinSize = CGSize(100,24)
        _ = textTest
//        textTest?.setText("test")
        
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
        Section{
            fill:blue;
            clear:left;
            float:left;
            width:220px;
            height:220px;
        }
        TextInput{
            width:240px;
            height:24px;
            float:left;
            clear:left;
            padding-top:2px;
        }
        
        TextInput Text{
            width:78px;
            height:24px;
            float:left;
            clear:left;
            font:Helvetica Neue;
            size:12px;
            align:left;
            type:input;
            color:grey6;
            selectable:true;
            wordWrap:true;
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
            wordWrap:true;
        }
        """
        StyleManager.addStyle(css)
        
        let section = window.contentView!.addSubView(Section())
       
        
        
//        let textTest:Text = section.addSubView(Text.init(text: "Hello world"))
        
        
        let textInput:TextInput = section.addSubView(TextInput.init(text: "Description: ", inputText: "blue"))
        _ = textInput
//        textInput.inputTextArea.setTextValue("hello")
        
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



