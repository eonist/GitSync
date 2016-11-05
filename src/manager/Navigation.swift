import Cocoa

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
class Navigation {
    static var activeView:String = MenuView.commits//<--default
    static var currentView:NSView? {return MainWin.mainView?.currentView}
    /**
     * Navigate between views
     */
    static func setView(viewName:String){
        Navigation.activeView = viewName
        Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        
        let width:CGFloat = MainView.w
        let height:CGFloat = MainView.h
        /**
         * TODO: Use class name instead of static let strings
         */
        switch viewName{
            case MenuView.commits:
                mainView.currentView = mainView.addSubView(CommitView(width,height,mainView))//CommitsView
            case MenuView.repos:
                mainView.currentView = mainView.addSubView(RepoView(width,height,mainView))
            case MenuView.stats:
                mainView.currentView = mainView.addSubView(StatsView(width,height,mainView))
            case MenuView.prefs:
                mainView.currentView = mainView.addSubView(PrefsView(width,height,mainView))
            case String(RepoDetailView):
                mainView.currentView = mainView.addSubView(RepoDetailView(width,height,mainView))
            case String(ConflictDialogView):
                mainView.currentView = mainView.addSubView(ConflictDialogView(width,height,mainView))
            case String(DebugView):
                mainView.currentView = mainView.addSubView(DebugView(width,height,mainView))
            case String(TestView):
                mainView.currentView = mainView.addSubView(TestView(width,height,mainView))
            default:
                break;
        }
    }
}
