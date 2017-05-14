import Cocoa
@testable import Element
@testable import Utils

class VibrantMainWin:TranslucentWin {
    convenience init(_ w:CGFloat,_ h:CGFloat){
        self.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        resolveSkin()
    }
    func resolveSkin() {
        MainWin.mainView = MainView(frame.size.width,frame.size.height,"")/*Sets the mainview of the window*/
        self.contentView?.addSubview(MainWin.mainView!)
    }
}
