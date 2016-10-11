import Foundation

/**
 * TODO: Migrate to its own .swift file when appropriate
 */
class Navigation {
    static var activeView:String = MenuView.commits//<--default
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
         *
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
            default:
                break;
        }
    }
}
