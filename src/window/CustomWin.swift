import Foundation

class CustomWin:Window{
    override func resolveSkin() {
        self.contentView = TestView3(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    override func windowDidResize(notification: NSNotification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
}