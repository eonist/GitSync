import Foundation

class MainView:TitleView{
    var title:String/*the title must be set after the init of the Window instance*/
    var menuView:MenuView?
    init(_ width: CGFloat, _ height: CGFloat,_ title:String = "", _ parent: IElement? = nil, _ id: String? = "") {
        self.title = title
        super.init(width, height, parent, "doc")
    }
    override func resolveSkin() {
        Swift.print("MainView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        menuView = self.addSubView(MenuView(width,40,self))
        Align.align(menuView!, CGSize(width/**/,height-20/**/), Alignment.bottomCenter, Alignment.bottomCenter,CGPoint(0,0))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}