import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    static var view:Element?
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(250,250)
        self.maxSize = CGSize(600,800)
    }
    override func resolveSkin() {
        view = StyleTestView(frame.size.width,frame.size.height)/*⬅️️🚪*/
        self.contentView = view
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
