import Cocoa
@testable import Utils
@testable import Element

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
enum Views{
    enum Main:String{
        case commits = "commits"
        case repos = "repos"
        case stats = "stats"
        case prefs = "prefs"
    }
    case main(Main)
    case commitDetail([String:String])
    case repoDetail(RepoItem)
    case dialog(Dialog)
    enum Dialog{
        case conflict
        case commit
    }
}
class Navigation {
    static var activeView:Views = Views.main(.commits)
    static var currentView:NSView? {return MainWin.mainView?.currentView}
    /**
     * Navigate between views
     */
    static func setView(_ view:Views){
        Navigation.activeView = view
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        mainView.menuView!.selectButton(view)/*Selects the correct menu icon*/
        
        let w:CGFloat = MainView.w/*Convenience*/
        let h:CGFloat = MainView.h
        
        switch view{
            /*Main*/
            case .main(let viewType):
                switch viewType {
                    case .commits:
                        mainView.currentView = mainView.addSubView(CommitsView(w,h,mainView))
                    case .repos:
                        mainView.currentView = mainView.addSubView(RepoView(w,h,mainView))
                    case .stats:
                        mainView.currentView = mainView.addSubView(StatsView(w,h,mainView))
                    case .prefs:
                        mainView.currentView = mainView.addSubView(PrefsView(w,h,mainView))
            }
            /*CommitDetail*/
            case .commitDetail(let commitData):
                mainView.currentView = mainView.addSubView(CommitDetailView(w,h,mainView))
                (mainView.currentView as! CommitDetailView).setCommitData(commitData)
            /*RepoDetail*/
            case .repoDetail(let repoItem):
                mainView.currentView = mainView.addSubView(RepoDetailView(w,h,mainView))
                (mainView.currentView as! RepoDetailView).setRepoData(repoItem)
            /*Dialogs*/
            case .dialog(let dialog):
                switch dialog{
                    case .commit:
                        fatalError("not implemented yet")
                    case .conflict:
                        mainView.currentView = mainView.addSubView(ConflictDialogView(w,h,mainView))
                }
        }
    }
}
