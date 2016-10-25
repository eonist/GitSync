import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide the interface when the mouse is not over the app (anim in and out) (maybe)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - A simple Git app")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        
        win = MainWin(MainView.w,MainView.h)
        //win = ConflictDialogWin(400,530)
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
        
        
        //Continue here:
        
        
            //commitDetailView
        
            //RepoDetailView should have a CheckBoxButton: Auto-sync
            //PrefsView should  have the Auto-sync-intervall: (as its too complicated to have individual timers, too much can go wrong)
            //path picker for localPath in repodetailview (folder icon)
            //add a eye-icon for find in finder feature in repodetailview
            //add an url-icon for open in safari feature in repodetailview
        
            //Tomorrow:
                //Implement RBSliderList for the commitsList
                //Implement a sync mode for the RBSliderList -> make a new class for this
        
        
            //To make the pull to sync feature, you need to make things work seperatly: (check mail app on iphone, and github projects)
                //make a circle that completes on a progress slider (done)
                //let a value iterate form 0 to 1 when scroll amount has travled far enough when list progress is bellow 0
                //implement the circle progress ticker show when pulling (pull to sync mode)
                //should the list be scrollable, while syncing? yes
                //Should the sync area be behind the list?
                //should the sync area be visible when the timer sets gitsync in sync mode?
                //RBList should read from an array but only display few at the time
                //Make sure all loose ends are covered
        
        
            //maybe you could just add a margin-top if the scrollview goes into refresh mode, and just show the refresh circle behind the scrollview
            
        //later
            //adjust the dialog designs
            //drag and drop support for .git urls -> adds it self to the top of the repo list
            //use the color themes from that opensource twitter client in electron
            //Dark mode mimicks twitter client
            //add logic to ConflictDialog
            //sync within individual repos from repodetailview
            //Figure out how to speed up live-refresh in Element (think object-trees)
            //Use the san-fran font (if you can find it)
            //at the end of commits list place a button with the text: named load more (load 20 at the time)
            //when you use the app for the first time, there is a demo repo added, hello-world from eonist which contains demo commits and a commit with instructions on how to use the app: pull to sunc: 2 finger swipe downwards , hold until the circle animation is spinning etc.
            //cmd click on repo items will reveal edit icon in top bar for multi edit feature
            //CMD + pull to refresh forces manual commit message (this is great since you then can create sort of bookmarks in your history, every commit until this was part of this latest commit msg, then think rebase)
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
