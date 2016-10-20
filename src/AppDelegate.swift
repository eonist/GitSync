import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide the interface when the mouse is not over the app (anim in and out)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - A really simple Git app")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        
        //win = MainWin(MainView.w,MainView.h)
        win = ConflictDialogWin(400,530)
        
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
        
            //move the menuview to the top, and do the GUI design from that screen, textbased with a bottom line (because the reason osx doesnt use bottom menues is because there is a system wide bottom menu)
        
            //add ConflicDialog to its own window because the GitSync win may be very small
            //Use The CSS from DrawLab promt win, grey etc, and DialogWin
            //make the CommitPromtDialog (Title,Description) <- prepopulate with derived data
        
            //Adjust the design in Conflict dialog
            //RepoDetailView should have a CheckBOxButton: Auto-sync
            //PrefsView should  have the Auto-sync-intervall: (as its too complicated to have individual timers, too much can go wrong)
            //path picker for localPath in repodetailview (folder icon)
        
            //add a eye-icon for find in finder feature in repodetailview
            //add an url-icon for open in safari feature in repodetailview
            //Implement RBSliderList for the commitsList
            //Implement a sync mode for the RBSliderList
            //Make the interactive circle animation (progress should be iterative)
        
            //To make the pull to sync feature, you need to make things work seperatly: (check mail app on iphone, and github projects)
                //make a circle anim animate on fps round and round (see github for insp, and raywenderlich)
                //make a circle that completes on a progress slider
                //let a value iterate form 0 to 1 when scroll amount has travled far enough when list progress is bellow 0
                //implement the circle progress ticker show when pulling (pull to sync mode)
                //should the list be scrollable, while syncing?
                //Should the sync area be behind the list?
                //should the sync area be visible when the timer sets gitsync in sync mode?
                //RBList should read from an array but only display few at the time
                //Make sure all loose ends are covered
        //later
            //consider using that greyish white you used on the first window demos for element, screen grab from ChromLessWin article
            //add darkmode checkboxbutton to prefsview
            //add logic to ConflictDialog
            //sync within individual repos from repodetailview
            //make the statsview Just add 2 text objects, Commits today: and Commits this week
            //Figure out how to speed up live-refresh in Element (think object-trees)
            //Use the san-fran font (if you can find it)
            //at the end of commits list place a button with the text: named load more (load 20 at the time)
        
        
    }
    func applicationWillTerminate(aNotification:NSNotification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
            xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
            xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
            xml.appendChild("<uiSounds>\(String(PrefsView.uiSoundsCheck!))</uiSounds>".xml)
            FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, xml.XMLString)
        }
        //store the repo xml
        if(RepoView.dp != nil){//make sure the data has been read and written to first
            FileModifier.write("~/Desktop/assets/xml/list.xml".tildePath, RepoView.dp!.xml.XMLString)
        }
        print("Good-bye")
    }
}
