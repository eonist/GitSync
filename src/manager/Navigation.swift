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
        
        let width:CGFloat = CommitsView.w
        let height:CGFloat = CommitsView.h
        /**
         * TODO: Use class name instead of static let strings
         */
        switch viewName{
            case MenuView.commits:
                mainView.currentView = mainView.addSubView(CommitsView(width,height,mainView))
            case MenuView.repos:
                mainView.currentView = mainView.addSubView(RepoView(width,height,mainView))
            case MenuView.stats:
                Swift.print("stats")
            case MenuView.prefs:
                Swift.print("prefs")
                mainView.currentView = mainView.addSubView(PrefsView(width,height,mainView))
            case String(RepoDetailView):
                mainView.currentView = mainView.addSubView(RepoDetailView(width,height,mainView))
            case String(ConflictDialogView):
                Swift.print("")
                mainView.currentView = mainView.addSubView(ConflictDialogView(width,height,mainView))
            
            default:
                break;
        }
    }
}
