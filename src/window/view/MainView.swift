import Foundation

class MainView:CustomView{
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("MainView.resolveSkin()")
    }
}