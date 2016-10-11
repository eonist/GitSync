import Foundation

class MainWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        self.contentView = MainView(frame.width,frame.height,"GitSync")/*Sets the mainview of the window*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * Stores centtralized data
 */
class Navigation {
    /**
     *
     */
    static func setView(viewName:String){
        Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        if(MainView.currentView != nil) {MainView.currentView!.removeFromSuperview()}
        let width:CGFloat = mainView!.width
        let height:CGFloat = mainView!.height
        /**
         *
         */
        switch viewName{
            case MenuView.commits:
                MainView.currentView = mainView!.addSubView(CommitsView(width,height,mainView))
            case MenuView.repos:
                MainView.currentView = mainView!.addSubView(RepoView(width,height,mainView))
            case MenuView.stats:
                Swift.print("stats")
            case MenuView.prefs:
                Swift.print("prefs")
            default:
                break;
        }
    }
}