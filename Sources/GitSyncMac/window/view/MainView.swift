import Foundation
@testable import Utils
@testable import Element

class MainView:TitleView{
    static let w:CGFloat = 700/*540,700*/
    static let h:CGFloat = 400/*350,400*/
    var title:String
    var menuView:MenuView?
    func createMenuView() -> MenuView{
        return addSubView(MenuView(frame.size.width,MenuView.h,self))
    }
    var currentView:Element?
    var conflictDialogWin:ConflictDialogWin?
    
    init(_ width:CGFloat, _ height:CGFloat,_ title:String = "", _ parent:IElement? = nil, _ id:String? = "") {
        self.title = title
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        super.resolveSkin()
        super.textArea.setTextValue(title)
        
        menuView = createMenuView()
        Navigation.setView(Views.main(.repository))/*Adds the correct view to MainView*/
    }
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        if let menuView = self.menuView {
            menuView.setSize(width, height)
            menuView.setSkinState(menuView.getSkinState())
        }
        if let currentView = currentView{currentView.setSize(width, height)}
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension MainView{
    /**
     *
     */
    func toggleMenuBar(_ hide:Bool){
        Swift.print("toggleSideBar: hide: " + "\(hide)")
        //remove leftSideBar
        if hide {
            if let menuView = self.menuView {
                menuView.removeFromSuperview()
            }
        }else{
            if menuView == nil{
                self.menuView = createMenuView()
            }
        }
        /*detailView.setSkinState(detailView.getSkinState())*/
        if let currentView = currentView{ElementModifier.float(currentView)}
        self.setSize(getWidth(),getHeight())
    }
}
