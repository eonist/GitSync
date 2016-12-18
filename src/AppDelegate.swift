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
        dataBaseTest()
    }
    /**
     *
     */
    func dataBaseTest(){
        //store index of item in repo-id coulmn     in     (date column)
        //date column stores items in a chronologically descending order
            //new items are first appended to the correct repo-id
            //then insert a tuple with (repo-id:Int,hash:String,date:Int) at an index you find with binarySearch
        //to retrive the last 100 items: db.sortedByDate.slice(0,100)
        //to retrive the last 100 from a speccific repo. Use git 
        
        //on refresh you should only insert commits that are new. 
            //So you need to keep track of which commits are new for each repo locally. 
                //you can do this with 'git show' when you refresh, rather that than complicating the dp
                    //then you only add commits that are newer than the locally newest commit. which you temp store before you commit or pull down changes
        
        //Continue here: 
            //things are working...moving on!
            //commitDB -> xml (use reflection)
            //XML -> CommitDB (xml parser)
        
        let commitDB = CommitDB()
        commitDB.add(Commit("","","","","",201602,"fak42a",0))
        commitDB.add(Commit("","","","","",201608,"2fae23",0))
        commitDB.add(Commit("","","","","",201601,"gr24g2",5))
        commitDB.add(Commit("","","","","",201611,"24ggq2",2))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        
        //Continue here: Reflection and unwrapping is working right out of the box
            //Moving on....to i guess storing the .xml and reloading the .xml file
        
        //you want to store more data in SortableCommit, the same info as in the Commit class actually. So SortableCommit should probably extend Commit. 
            //test if reflection still works when extending
        
        //you then need to figure out how to update this sorted list on refresh (next)
            //you could keep a DP instance for ListView that you prepend new items onto
                //you compare the two lists by getting the first of ListView.dp and the first of ComitDB.sortedByDate.slice(0,100)
                //then create a custom merge method that efficiently merges sortedByDates onto ListView.dp
                //keep in mind that 2 commits can have the same commit time stamp, <---think about this
        
        //a:
            //16
            //15
            //12 <--
            //10
            //5
            //2
        
        //b:
            //12 (<--first)
            //10
            //5
            //2
        
        
        
        
        
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