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
        menuView = self.addSubView(MenuView(200,40,self))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}