import Foundation

class CommitDialogView:TitleView{
    private var okButton:TextButton?
    private var cancelButton:TextButton?
    
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","Review local version","Review remote version","Review mix of both versions"]
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "commitDialog")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue("Commit message:")
        
        createGUI()
        //Swift.print(ElementParser.stackString(self))
    }
    /**
     *
     */
    func createGUI(){
        
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
