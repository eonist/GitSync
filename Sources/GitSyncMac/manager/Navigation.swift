import Cocoa
@testable import Utils
@testable import Element

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
enum Views {
    case commits
    case repos
    case repoDetail(RepoItem)
    case stats
    case prefs
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
        Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        
        let width:CGFloat = MainView.w
        let height:CGFloat = MainView.h
        /**
         * TODO: Use class name instead of static let strings, actually use enums enum can support conditions so you can get to repoDetailView with specific data etc
         */
        switch viewName{
            case MenuView.commits:
                Swift.print("set commits win")
                mainView.currentView = mainView.addSubView(CommitsView(width,height,mainView))
            case MenuView.repos:
                mainView.currentView = mainView.addSubView(RepoView(width,height,mainView))
            case MenuView.stats:
                mainView.currentView = mainView.addSubView(StatsView(width,height,mainView))
            case MenuView.prefs:
                Swift.print("set prefs win")
                mainView.currentView = mainView.addSubView(PrefsView(width,height,mainView))
            case "\(RepoDetailView.self)":
                mainView.currentView = mainView.addSubView(RepoDetailView(width,height,mainView))
            case "\(ConflictDialogView.self)":
                mainView.currentView = mainView.addSubView(ConflictDialogView(width,height,mainView))
            /* case "\(TestView3.self)":
             mainView.currentView = mainView.addSubView(TestView3(width,height,mainView))
             case "\(TestView2.self)":
             mainView.currentView = mainView.addSubView(TestView2(width,height,mainView))*/
            case "\(CommitDetailView.self)":
                Swift.print("set CommitDetailView win")
                mainView.currentView = mainView.addSubView(CommitDetailView(width,height,mainView))
            default:
                break;
        }
    }
}
