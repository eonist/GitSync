import Foundation

class BasicView:CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("hello world")
    }
}