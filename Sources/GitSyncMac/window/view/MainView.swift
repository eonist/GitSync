import Foundation
@testable import Utils
@testable import Element

class MainView:TitleView{
    static let w:CGFloat = 700//540//700
    static let h:CGFloat = 400//350//400
    var title:String
    static var menuView:MenuView?
    var currentView:Element?
    var conflictDialogWin:ConflictDialogWin?
    
    init(_ width:CGFloat, _ height:CGFloat,_ title:String = "", _ parent:IElement? = nil, _ id:String? = "") {
        self.title = title
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        super.resolveSkin()
        super.textArea.setTextValue(title)
        //Sounds.startup?.play()
        MainWin.mainView = self
        MainView.menuView = addSubView(MenuView(frame.size.width,48,self))
        Navigation.setView(Views.main(.repository))/*Adds the correct view to MainView*/
    }
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        if let currentView = currentView{currentView.setSize(width, height)}
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
