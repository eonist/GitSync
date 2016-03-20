import Foundation

class MainView:CustomView{
    var leftContainer:
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        super.resolveSkin()
        leftSideBar = addSubView(LeftSideBar(LeftSideBar.w,height,self))
    }
}
