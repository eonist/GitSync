import Foundation

class MainView:CustomView{
    var leftSection:Section?
    var leftSideBar:LeftSideBar?
    //var contentView:ContentView?
    var currentView:Element?
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStyle("Section#leftSection{fill:#E2E2E5;fill-alpha:0;corner-radius:4px 0px 4px 0px;float:left;clear:none;}")
        
        leftSection = addSubView(Section(LeftSideBar.w,600,self,"leftSection"))
        createCustomTitleBar()
        leftSideBar = leftSection!.addSubView(LeftSideBar(LeftSideBar.w,height,leftSection))
        //currentView = addSubView(ContentView(width-LeftSideBar.w,height,self))
        Navigation.sharedInstance.mainView = self
        Navigation.sharedInstance.setView(LeftSideBar.actvity)
    }
    /**
     *
     */
    func createCustomTitleBar() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:12px;}")
        
        section = leftSection!.addSubView(Section(LeftSideBar.w,16,leftSection,"titleBar"))
        closeButton = section!.addSubView(Button(0,0,section!,"close"))/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize"))
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize"))
    }
    override func createTitleBar() {
        //
    }
}
/**
 * Stores centtralized data
 */
class Navigation {
    var mainView:MainView?
    static var sharedInstance = Navigation()
    private init() {
        //init stuff here
    }
    /**
     *
     */
    func setView(viewName:String){
        Swift.print("Navigation.setView() viewName: " + "\(viewName)")
        if(mainView!.currentView != nil) {mainView!.currentView!.removeFromSuperview()}
        let width:CGFloat = mainView!.width-LeftSideBar.w
        let height:CGFloat = mainView!.height
        switch viewName{
            case LeftSideBar.actvity:
                mainView!.currentView = mainView!.addSubView(ActivityView(width,height,mainView))
            case LeftSideBar.repos:
                mainView!.currentView = mainView!.addSubView(ContentView(width,height,mainView))
            case LeftSideBar.stats:
                Swift.print("")
            case LeftSideBar.settings:
                Swift.print("")
            default:
                break;
        }
        
        
        
    }
}