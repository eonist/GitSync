import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class TestView:TitleView{
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "listTransitionTestView")
    }
    override func resolveSkin(){
        Swift.print("ListTransitionTestView.resolveSkin()")
        super.resolveSkin()
        Swift.print(ElementParser.stackString(self))
        createGUI()
    }
    func createGUI(){
        createGraph9Test()
    }
    func createGraph9Test(){
        let graph = self.addSubView(Graph9(width,height-48,self))
        _ = graph
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
