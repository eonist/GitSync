import Foundation

class CommitDialogWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        Swift.print("frame.width: " + "\(frame.width)")
        Swift.print("frame.height: " + "\(frame.height)")
        self.contentView = CommitDialogView(frame.width,frame.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}