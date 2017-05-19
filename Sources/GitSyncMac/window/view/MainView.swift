import Foundation
@testable import Utils
@testable import Element

class MainView:TitleView{
    static let w:CGFloat = 700//540//700
    static let h:CGFloat = 400//350//400
    var title:String
    static var menuView:MenuView?
    
    var _currentView:Element? = nil
    var currentView:Element {
        guard let view = _currentView else{
            _currentView = Navigation.view(Views.main(.repository),self,CGSize(MainView.w,MainView.h))/*Adds the correct view to MainView*/
            return self.addSubView(_currentView!)
        };return view
    }
    
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
        _ = currentView
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
