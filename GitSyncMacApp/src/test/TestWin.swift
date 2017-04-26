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
        //self.contentView = TestView(frame.size.width,frame.size.height,nil,"listTransitionTestView")
        //self.contentView = RepoListTestView(frame.size.width,frame.size.height)
        self.contentView = MinimalView(frame.size.width,frame.size.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class MinimalView:WindowView{
    override func resolveSkin(){
        let css:String = "Window{fill:white;fill-alpha:1;corner-radius:4px;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        let stackString = ElementParser.stackString(self)
        Swift.print("stackString: " + "\(stackString)")
        rotationUITest()
    }
    func rotationUITest(){
        
        let css = "Button#test{fill:blue;}"
        StyleManager.addStyle(css)
        let btn = addSubView(Button(20,20,self,"test"))
        _ = btn
    }
    func treeList(){
        let dp:TreeDP2 = TreeDP2("~/Desktop/assets/xml/treelist.xml".tildePath)
        _ = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
    }
}
