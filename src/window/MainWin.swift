import Foundation

class MainWin:Window {
    override func resolveSkin() {
        //      Swift.print("frame.width: " + "\(frame.width)")
        //      Swift.print("frame.height: " + "\(frame.height)")
        self.contentView = MainView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
}