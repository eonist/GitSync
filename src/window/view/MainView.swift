import Foundation

class MainView:CustomView{
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        super.resolveSkin()
    }
}
