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
        case repository = "repository"
    }
    case main(Main)
    case commitDetail([String:String])
    case repoDetail([Int])
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
    static func view(_ view:Views,_ curView:NSView?)->NSView{
        Navigation.activeView = view
        if let curView = curView {curView.removeFromSuperview()}
        MainView.menuView!.selectButton(view)/*Selects the correct menu icon*/
        
        let w:CGFloat = MainView.w/*Convenience*/
        let h:CGFloat = MainView.h
        
        switch view{
            case .main(let viewType):/*Main*/
                switch viewType {
                    case .commits:
                        return CommitsView(w,h,mainView)
                    case .repos:
                        mainView.currentView = mainView.addSubView(RepoView(w,h,mainView))
                    case .stats:
                        mainView.currentView = mainView.addSubView(StatsView(w,h,mainView))
                    case .prefs:
                        mainView.currentView = mainView.addSubView(PrefsView(w,h,mainView))
                    case .repository:
                        mainView.currentView = mainView.addSubView(RepositoryView(w,h,mainView))
            }
            case .commitDetail(let commitData):/*CommitDetail*/
                mainView.currentView = mainView.addSubView(CommitDetailView(w,h,mainView))
                (mainView.currentView as! CommitDetailView).setCommitData(commitData)
            case .repoDetail(let idx3d):/*RepoDetail*/
                mainView.currentView = mainView.addSubView(RepoDetailView(w,h,mainView))
                (mainView.currentView as! RepoDetailView).setRepoData(idx3d)
            case .dialog(let dialog):/*Dialogs*/
                switch dialog{
                    case .commit:
                        fatalError("not implemented yet")
                    case .conflict:
                        mainView.currentView = mainView.addSubView(ConflictDialogView(w,h,mainView))
                }
        }
    }
}
