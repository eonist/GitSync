import Foundation

class CustomWin:Window{
    override func resolveSkin() {
        self.contentView = CustomView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
}