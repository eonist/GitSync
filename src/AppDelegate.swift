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
        
        win = MainWin(MainView.w,MainView.h)
        
        let url:String = "~/Desktop/ElCapitan/gitsync.css"
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                Swift.print("update to the file happened")
                StyleManager.addStylesByURL(url,true)
                let view:NSView = MainWin.mainView!
                ElementModifier.refreshSkin(view as! IElement)
                ElementModifier.floatChildren(view)
            }
        }
        fileWatcher!.start()
        
        
        //Continue here:
            //prefs from app-menu
            //make the app-menu (see drawlab)
            //Make the PrefsView (with back-button)
            //start creating the prefsView
            //path picker for localPath in repodetailview
            //on item click -> go to RepoDetailView
            //Add trashcan icon in the topBar of the RepoDetailView
            //Remove the removeIcon in RepoView, also the editICon
            //when you create a new item -> write xml to disk
            //make the conflict resolution dialog (use boilerplate from DrawLab)
            //commit popup dialog
            //seconds text to auto increment, also fix the color, Auto commit message [x], 
        //later
            //Figure out how to speed up live-refresh in Element (think object-trees)
            //Use the san-fran font (if you can find it)
            //at the end of commits list place a button with the text: named load more (load 20 at the time)
        
        
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}
