import Foundation

class MainView:CustomView{
    var leftContainer:Container?
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        super.resolveSkin()
        leftContainer = Container(0,0,self)
        leftSideBar = leftContainer!.addSubView(LeftSideBar(LeftSideBar.w,height,self))
    }
}
