import Foundation

class ConflictDialogWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        MainWin.mainView = MainView(frame.width,frame.height,"GitSync")/*Sets the mainview of the window*/
        self.contentView = MainWin.mainView!
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//Continue here: Use ideas from the combobox implementation to alert the initiater that the DialogWin has clodes
//Check PromtWin from DrawLab for css and implementation details

class ConflictDialogView:TitleView{
    static let w:CGFloat = 220
    static let h:CGFloat = 380
    var title:String/*the title must be set after the init of the Window instance*/
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","review local version","review remote version","review mix of both versions"]
    
    init(_ width: CGFloat, _ height: CGFloat,_ title:String = "", _ parent: IElement? = nil, _ id: String? = "") {
        self.title = title
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        
        //Title: Resolve merge conflict:
        //Repo title: Element iOS
        //File: ~/documents/element-ios/AppDelegate.swift
        //
        //create a list with the mergeOptions
        //
        //on select
        
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}