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
        //reflectionDictTest()
        ioTest()
        //dataBaseTest()
    }
    /**
     *
     */
    func reflectionDictTest(){
        
        let temp:Temp = Temp([0:"test",3:"testing",5:"more testing"])//create a dict
        let xml:XML = Reflection.toXML(temp) //reflect the dict to xml
        Swift.print(xml.XMLString)//print the xml
        
        let newInstance:Temp = Temp.unWrap(xml)!//unwrap the xml to dict
        newInstance.someDict.forEach{
            Swift.print("key: \($0.0) value: \($0.1)")
        }
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
    }
    /**
     *
     */
    func ioTest(){
        let commitDB = CommitDBCache.read()
        
        Swift.print("Printing sortedArr after unwrap: ")
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        Swift.print("Printing prevCommits after unwrap: ")
        commitDB.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
        /*
        commitDB.add(Commit("","","","","",201609,"f2o33f",3))
        CommitDBCache.write(commitDB)
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
                    //I think CommitDB should hold this index. yes!!!
            //loop through repos and get the last local commit
                //
            //loop through repos and check for new commits
                //insert new commits to CommitDB
            //on loop complete
                //populate CommitView w/ data from CommitDB
        
        //Continue here, io works✅, db works✅,unwrap Dict works✅
            //make a plan for the next tasks: probably work with real data
                //You need to find all commits from the first until the hash stored in CommitDB
                    //If no hash is stored in CommitDB for the repo
                        //then the the range will be 0..commitCount
                        //else range: 0..hash.from.CommitDB
                //make a test for this
                //then you store these commits to CommitDB, repoID is its index in repoList
                //then you try refreshing again, and check if the commits are read and stored correctly etc
        
        //👉Update CommitDB on App Init👈
            //1. unwrap commitdb.xml
            //2. update CommitDB
                //loop over all repos
                    //loop over all new commits
                        //figure out which commits are new by using range 0..commitDB.prevCommits[repo-id].hash🚫
            //3. when commitDB refresh is complete
                //init app GUI🚀
        
        //You don't need to store more commits than nessaccery in CommitDB 🚫
            //max 100 commits per repo
                //which means you need to store commits per repo after all
                //to remove the correct item from sortedByDates array
                    //store the index of the location
        
        //sortedByDate should actually pop of the last item if the count excedes a limit
            //
        //The sortedByDate will have a date range (first..last)
            //this date range will be important to keep the array at max count 🔑 (when you add/remove new repos for instance)
            //when you loop commits 
                //only commits that are made after the last date in sortedByDate
                    //make a git method that can find the hash of a commit nearest a data. 👈
        
        
        //The new refresh commitDB algo🤖: (this refresh method needs to be acceccable from many places, so add it in CommitDBUtils.refresh())
            //You loop the repos
                //find the range of commits to add to CommitDB for this repo
                //if CommitDB.sortedByDates.count > 100
                    //let lastDate = .count > 0 ? sortedByDates.last.date : Int.min<--min represents max negative num
                    //range = now..lastDate in the repo (date based) Needs --> 🔬 (how does querrying for date ranges in git work)
                    //let firstDate in range🚫 <-- add this optimization later
                    //find the index in sortedByDates🚫<-- add this optimization later
                    //(sortedByDates.count - index)🚫<-- add this optimization later
                //else //< 100
                    //let available = max - sortedByDates.count
                    //range = 0..available (count based)
                //retrive the commit log items for this repo with the range speccified
                //add the commit log items to the CommitDB
        
        
        //what happens if a commit was deleted? -> 
            //it stays in the CommitDb until its poped of the end (this is an edge case and could be dealt with later)
        //what happens if a repo is removed from the app?
            //for loop sortedByDates and remove items matching the repo hash, do the same for prevCommit Dictionary
                //then run the refresh algo🤖 to repopulate the CommitList
        
        
        //Continue here:
            //do the git date range research and tests
                //commit count after date ✅
            //make the refresh CommitDB algo🤖 as described
            //how do we refresh after commits and pushes to remote? 👉 after 👈 because -> simplicity 👌
        

        
        let commitDB = CommitDB()
        commitDB.add(Commit("","","","","",201602,"fak42a",0))
        commitDB.add(Commit("","","","","",201608,"2fae23",0))
        commitDB.add(Commit("","","","","",201601,"gr24g2",5))
        commitDB.add(Commit("","","","","",201611,"24ggq2",2))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        Swift.print(xml.XMLString)
        let newInstance:CommitDB = CommitDB.unWrap(xml)!/*UnWrapping*/
        Swift.print("Printing sortedArr after unwrap: ")
        newInstance.sortedArr.forEach{Swift.print($0.sortableDate)}
        Swift.print("Printing prevCommits after unwrap: ")
        newInstance.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
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
private class Temp{
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