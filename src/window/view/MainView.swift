import Foundation

class MainView:CustomView{
    var leftSection:Section?
    var leftSideBar:LeftSideBar?
    var contentView:ContentView?
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStyle("Section#leftSection{fill:#E2E2E5;fill-alpha:0;corner-radius:4px 0px 4px 0px;float:left;clear:none;}")
        leftSection = addSubView(Section(LeftSideBar.w,600,self,"leftSection"))
        createCustomTitleBar()
        leftSideBar = leftSection!.addSubView(LeftSideBar(LeftSideBar.w,height,leftSection))
        contentView = addSubView(ContentView(width-LeftSideBar.w,height,self))
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
