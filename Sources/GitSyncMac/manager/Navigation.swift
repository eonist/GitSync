import Cocoa
@testable import Utils
@testable import Element

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
enum Views{
    case commits
    case commitDetail([String:String])
    case repos
    case repoDetail(RepoItem)
    case stats
    case prefs
    case dialog(Dialog)
    enum Dialog{
        case conflict
        case commit
    }
}
class Navigation {
    static var activeView:Views = .commits//<--default
    static var currentView:NSView? {return MainWin.mainView?.currentView}
    /**
     * Navigate between views
     */
    static func setView(_ view:Views){
        //menuView!.selectGroup!.selectedAt(0)/*Selects the correct menu icon*/
        
        Navigation.activeView = view
        //Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        
        let w:CGFloat = MainView.w
        let h:CGFloat = MainView.h
        
        switch view{
            case .commits:
                mainView.currentView = mainView.addSubView(CommitsView(w,h,mainView))
            case .commitDetail(let commitData):
                mainView.currentView = mainView.addSubView(CommitDetailView(w,h,mainView))
                (mainView.currentView as! CommitDetailView).setCommitData(commitData)
            case .repos:
                mainView.currentView = mainView.addSubView(RepoView(w,h,mainView))
            case .repoDetail(let repoItem):
                Swift.print("repoItem: " + "\(repoItem)")
                mainView.currentView = mainView.addSubView(RepoDetailView(w,h,mainView))
                (mainView.currentView as! RepoDetailView).setRepoData(repoItem)
            case .stats:
                mainView.currentView = mainView.addSubView(StatsView(w,h,mainView))
            case .prefs:
                mainView.currentView = mainView.addSubView(PrefsView(w,h,mainView))
            case .dialog(let dialog):
                print("")
                switch dialog{
                    case .commit:
                        print("")
                    case .conflict:
                        mainView.currentView = mainView.addSubView(ConflictDialogView(w,h,mainView))
                }
        }
    }
}
