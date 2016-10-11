import Foundation

class MainWin:Window {
    static var mainView:MainView?
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        self.contentView = MainView(frame.width,frame.height,"GitSync")/*Sets the mainview of the window*/
        MainWin.mainView = self.contentView as? MainView
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * TODO: Migrate to its own .swift file when appropriate
 */
class Navigation {
    /**
     * Navigate between views
     */
    static func setView(viewName:String){
        Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        let mainView:MainView = MainWin.mainView!
        if(mainView.currentView != nil) {mainView.currentView!.removeFromSuperview()}
        
        let width:CGFloat = CommitsView.w
        let height:CGFloat = CommitsView.h
        
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