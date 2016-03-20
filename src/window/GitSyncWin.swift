import Foundation

class GitSyncWin:Window {
    override func resolveSkin() {
        self.contentView = MainView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
}