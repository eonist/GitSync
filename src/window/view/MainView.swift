import Foundation

class MainView:CustomView{
    var leftContainer:Container?
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        super.resolveSkin()
        leftContainer = addSubView(Container(0,0,self))
        createCustomTitleBar()
        leftSideBar = leftContainer!.addSubView(LeftSideBar(LeftSideBar.w,height,leftContainer))
    }
    /**
     *
     */
    func createCustomTitleBar() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:12px;}")
        
        section = leftContainer!.addSubView(Section(75,16,leftContainer,"titleBar"))
        closeButton = section!.addSubView(Button(0,0,section!,"close"))/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize"))
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize"))
    }
    override func createTitleBar() {
        //
    }
}
