import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        Swift.print("StyleTestWin.init")
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(250,250)
        self.maxSize = CGSize(600,800)
    }
    override func resolveSkin() {
        self.contentView = StyleTestView.shared
//        Nav.setView(.dialog(.commit))/*⬅️️🚪*///
        Nav.setView(.dialog(.conflict))
//        Nav.setView(.main(.commit))
        //Nav.setView(.repoDetail([0,0,0]))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
