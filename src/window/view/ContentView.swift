import Foundation

class ContentView:Container{
    override func resolveSkin() {
        StyleManager.addStyle("ContentView{float:left;clear:none;fill:orange;}")
        super.resolveSkin()
    }
}