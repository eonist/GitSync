import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window { /*TranslucentWin*/
    //var view:Element?
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(300,350)
        self.maxSize = CGSize(500,700)
    }
    override func resolveSkin() {
        self.contentView = StyleTestView(frame.size.width,frame.size.height)//340,(400 + 10)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
