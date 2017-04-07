import Cocoa
@testable import Utils
@testable import Element

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
enum Views {
    case commits
    case commitDetail([String:String])
    case repos
    case repoDetail(RepoItem)
    case stats
    case prefs
    case dialog(Dialog)
}
enum Dialog{
    case conflict
    case commit
}
class Navigation {
    static var activeView:String = MenuView.commits//<--default
    static var currentView:NSView? {return MainWin.mainView?.currentView}
    /**
     * Navigate between views
     * TODO: Use enums 
     */
    static func setView(_ viewName:String){
        Navigation.activeView = viewName
        //Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        
        let w:CGFloat = MainView.w
        let height:CGFloat = MainView.h
        let view:Views = "" == "" ? .commits : .repos
        
        switch view{
            case .commits:
                mainView.currentView = mainView.addSubView(CommitsView(w,height,mainView))
            case .commitDetail(let commitData):
                mainView.currentView = mainView.addSubView(CommitDetailView(w,height,mainView))
                (mainView.currentView as! CommitDetailView).setCommitData(commitData)
            case .repos:
                mainView.currentView = mainView.addSubView(RepoView(w,height,mainView))
            case .repoDetail(let repoItem):
                Swift.print("repoItem: " + "\(repoItem)")
                mainView.currentView = mainView.addSubView(RepoDetailView(w,height,mainView))
                (mainView.currentView as! RepoDetailView).setRepoData(repoItem)
            case .stats:
                mainView.currentView = mainView.addSubView(StatsView(w,height,mainView))
            case .prefs:
                mainView.currentView = mainView.addSubView(PrefsView(w,height,mainView))
            case .dialog(let dialog):
                print("")
                switch dialog{
                    case .commit:
                        print("")
                    case .conflict:
                        mainView.currentView = mainView.addSubView(ConflictDialogView(w,height,mainView))
                }
            
        }
        
        
        /**
         * TODO: Use class name instead of static let strings, actually use enums enum can support conditions so you can get to repoDetailView with specific data etc
         */
        switch viewName{
            case MenuView.commits:
                Swift.print("set commits win")
            
            case MenuView.repos:
            
            case MenuView.stats:
            
            case MenuView.prefs:
                Swift.print("set prefs win")
            
            case "\(RepoDetailView.self)":
            
            case "\(ConflictDialogView.self)":
            
            /* case "\(TestView3.self)":
             mainView.currentView = mainView.addSubView(TestView3(width,height,mainView))
             case "\(TestView2.self)":
             mainView.currentView = mainView.addSubView(TestView2(width,height,mainView))*/
            case "\(CommitDetailView.self)":
                Swift.print("set CommitDetailView win")
            
            default:
                break;
        }
    }
}
