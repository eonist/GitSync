import Foundation

class MainView:TitleView{
    var title:String/*the title must be set after the init of the Window instance*/
    var menuView:MenuView?
    var commitsView:CommitsView?
    var fileWatcher:FileWatcher?
    init(_ width: CGFloat, _ height: CGFloat,_ title:String = "", _ parent: IElement? = nil, _ id: String? = "") {
        self.title = title
        super.init(width, height, parent, "doc")
        
        let url:String = "~/Desktop/ElCapitan/gitsync.css"
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                Swift.print("update to the file happened")
                StyleManager.addStylesByURL(url,true)
                ElementModifier.refreshSkin(self)
                ElementModifier.floatChildren(self)
            }
        }
        fileWatcher!.start()
        
    }
    override func resolveSkin() {
        Swift.print("MainView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        commitsView = addSubView(CommitsView(320,height-36-36,self))
        menuView = addSubView(MenuView(240,36,self))
        Align.align(menuView!, CGSize(width/**/,height/**/), Alignment.bottomCenter, Alignment.bottomCenter,CGPoint(0,0))
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}