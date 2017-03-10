import Foundation
@testable import Utils
@testable import Element

class MainView:TitleView{
    static let w:CGFloat = 540
    static let h:CGFloat = 350
    var title:String/*the title must be set after the init of the Window instance*/
    var menuView:MenuView?
    var currentView:Element?
    var conflictDialogWin:ConflictDialogWin?
    
    init(_ width:CGFloat, _ height:CGFloat,_ title:String = "", _ parent:IElement? = nil, _ id:String? = "") {
        self.title = title
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        //Swift.print("MainView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        Sounds.startup?.play()
        MainWin.mainView = self
        menuView = addSubView(MenuView(frame.size.width,48,self))
        Navigation.setView(MenuView.commits)/*adds the correct view to MainView*/
        //Navigation.setView(MenuView.repos)
        Navigation.setView("\(RepoDetailView.self)")
        //menuView!.selectGroup!.selectedAt(0)/*Selects the correct menu icon*/
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
