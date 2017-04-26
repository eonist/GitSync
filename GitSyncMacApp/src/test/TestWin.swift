import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class TestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        //Swift.print("frame.width: " + "\(frame.size.width)")
        //Swift.print("frame.height: " + "\(frame.size.height)")
        self.contentView = TestView(frame.size.width,frame.size.height,nil,"listTransitionTestView")
        //self.contentView = RepoListTestView(frame.size.width,frame.size.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
