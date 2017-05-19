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
    /*    
     static var activeView:Views = Views.main(.commits)
     static var currentView:NSView? {return MainWin.mainView?.currentView}
     */
    /**
     * Navigate between views
     */
    static func setView(_ viewType:Views){
        //Navigation.activeView = view
        let mainView:MainView = MainWin.mainView!
        let size:CGSize = CGSize(MainView.w,MainView.h)
        if let curView = mainView.currentView {curView.removeFromSuperview()}
        MainView.menuView!.selectButton(viewType)/*Selects the correct menu icon*/
        mainView.currentView = mainView.addSubView(getView(viewType,mainView,size))
    }
    private static func getView(_ view:Views,_ mainView:Element,_ size:CGSize)->Element{
        let w:CGFloat = size.w/*Convenience*/
        let h:CGFloat = size.h
        switch view{
        case .main(let viewType):/*Main*/
            switch viewType {
            case .commits:
                return CommitsView(w,h,mainView)
            case .repos:
                return RepoView(w,h,mainView)
            case .stats:
                return StatsView(w,h,mainView)
            case .prefs:
                return PrefsView(w,h,mainView)
            case .repository:
                return RepositoryView(w,h,mainView)
            }
        case .commitDetail(let commitData):/*CommitDetail*/
            let view:CommitDetailView = CommitDetailView(w,h,mainView)
            view.setCommitData(commitData)
            return view
        case .repoDetail(let idx3d):/*RepoDetail*/
            let view:RepoDetailView = RepoDetailView(w,h,mainView)
            view.setRepoData(idx3d)
            return view
        case .dialog(let dialog):/*Dialogs*/
            switch dialog{
            case .commit:
                fatalError("not implemented yet")
            case .conflict:
                return ConflictDialogView(w,h,mainView)
            }
        }
    }
}
