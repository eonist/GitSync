import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   @IBOutlet weak var window: NSWindow!
   /**
    * Creates the view
    */
   lazy var mainView: MainView = createMainView()
   func applicationDidFinishLaunching(_ aNotification: Notification) {
      _ = mainView
//      Nav.setView(viewType: .prefs(.repo(.repoList)))
//      Nav.setView(viewType: .prefs(.repo(.repoDetail(repoName: "0"))))
//      Nav.setView(viewType: .dialog(.commit(repoName: "Gitsync", commitMSG: "Fix bug")))
//       Nav.setView(viewType: .dialog(.mergeConflict(conflict: "remote newer than local")))
//       Nav.setView(viewType: .dialog(.autoInit(conflict: "There is no folder in the file path...")))
      Nav.setView(viewType: .dialog(.error(problem: "No internet connection")))
      
      //🏀
         //test if repoListView works
         // then add repodetail view
      
//      Nav.setView(viewType: .commitList)
//      Nav.setView(viewType: .prefs(.prefsList))
   }
}

//      Nav.setView(.main(.commit),styleTestView:styleTestView)
//      Nav.setView(.dialog(.commit(RepoItem.dummyData, CommitMessage.dummyData)))
//      Nav.setView(.dialog(.conflict(MergeConflict.dummyData)))
//      let repoItem = RepoItem(local: "~/dev/demo",branch: "master",title: "demo",remote: "https://github.com/gitsync/demo2.git")
//      Nav.setView(.dialog(.autoInit(AutoInitConflict(repoItem),{})))
//      Nav.setView(.detail(.repo([0,1,0])))
//      Nav.setView(.main(.repo))
//      Nav.setView(.main(.prefs))
