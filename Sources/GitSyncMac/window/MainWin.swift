import Foundation
@testable import Utils
@testable import Element

//Resize titlebar 🏀

class MainWin:Window {
    static var mainView:MainView?
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        MainWin.mainView = MainView(frame.size.width,frame.size.height,"")/*Sets the mainview of the window*/
        self.contentView = MainWin.mainView!
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
