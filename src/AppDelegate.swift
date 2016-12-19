import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide parts of the interface when the mouse is not over the app (anim in and out) (maybe)
 */
@NSApplicationMain
class AppDelegate:NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - Simple git automation for macOS")
        
        //initApp()
        reflectionDictTest()
        //ioTest()
        //dataBaseTest()
    }
    /**
     *
     */
    func reflectionDictTest(){
        //create a dict
        //let someDict:[Int:String] = [0:"test"]
        //let temp:Any = someDict
        //Swift.print("\(temp is AnyDictionary)")
        let temp:Temp = Temp([0:"test",3:"testing",5:"more testing"])
        let xml:XML = Reflection.toXML(temp)
        Swift.print(xml.XMLString)
        
        let newInstance:Temp = Temp.unWrap(xml)!
        newInstance.someDict.forEach{
            Swift.print("key: \($0.0) value: \($0.1)")
        }
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        //reflect the dict to xml
            //see xmlParser for tips in this regard
        //unwrap the xml to dict
        
        //Continue here: test with a class that has a dict
    }
    /**
     *
     */
    func ioTest(){
        let commitDB = CommitCache.read()
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        /*
        commitDB.add(Commit("","","","","",201609,"f2o33f",3))
        CommitCache.write(commitDB)
        */
        
        //Continue here: reading and writing works...next task!
    }
    /**
     *
     */
    func dataBaseTest(){
        
        //Continue here:
            //store xml to disk
            //retrive xml to structs
            //When you add a new repo. The hash id of the first commit is added as the newest commit to that repo.
                //this hash id is then updated to always represent the last commit?!?!?<--is this a good idea?
                    //I think CommitDB should hold this index. 
            //loop through repos and get the last local commit
                //
            //loop through repos and check for new commits
                //insert new commits to CommitDB
            //on loop complete
                //populate CommitView
        
        let commitDB = CommitDB()
        commitDB.add(Commit("","","","","",201602,"fak42a",0))
        commitDB.add(Commit("","","","","",201608,"2fae23",0))
        commitDB.add(Commit("","","","","",201601,"gr24g2",5))
        commitDB.add(Commit("","","","","",201611,"24ggq2",2))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        Swift.print(xml.XMLString)//Output: <Temp><color type="NSColor">FFFF0000</color></Temp>
        let newInstance:CommitDB = CommitDB.unWrap(xml)!/*UnWrapping*/
        Swift.print("Printing sortedArr after unwrap: ")
        newInstance.sortedArr.forEach{Swift.print($0.sortableDate)}
    }
    func initApp(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        
        win = MainWin(MainView.w,MainView.h)
        //win = ConflictDialogWin(380,400)
        //win = CommitDialogWin(400,356)
        
        let url:String = "~/Desktop/ElCapitan/gitsync.css"
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
        fileWatcher!.start()
    }
    func applicationWillTerminate(aNotification:NSNotification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
            xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
            xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
            xml.appendChild("<uiSounds>\(String(PrefsView.uiSounds!))</uiSounds>".xml)
            FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, xml.XMLString)
        }
        //store the repo xml
        if(RepoView.dp != nil){//make sure the data has been read and written to first
            FileModifier.write("~/Desktop/assets/xml/list.xml".tildePath, RepoView.dp!.xml.XMLString)
        }
        print("Good-bye")
    }
}
class Temp{
    var someDict:[Int:String]
    init(_ someDict:[Int:String]){
        self.someDict = someDict
    }
}
extension Temp:UnWrappable{
    static func unWrap<T>(xml:XML) -> T? {
        let someDict:[Int:String] = unWrap(xml,"someDict")
        return Temp(someDict) as? T
    }
}