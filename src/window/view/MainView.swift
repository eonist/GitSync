import Foundation

class MainView:CustomView{
    var leftSection:Section?
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStyle("Section#leftSection{fill:blue;}")
        leftSection = addSubView(Section(75,400,self,"leftSection"))
        createCustomTitleBar()
        leftSideBar = leftSection!.addSubView(LeftSideBar(LeftSideBar.w,height,leftSection))
    }
    /**
     *
     */
    func createCustomTitleBar() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:12px;}")
        
        section = leftSection!.addSubView(Section(75,16,leftSection,"titleBar"))
        closeButton = section!.addSubView(Button(0,0,section!,"close"))/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize"))
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize"))
    }
    override func createTitleBar() {
        //
    }
}
