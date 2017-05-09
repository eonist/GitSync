import Foundation
@testable import Utils
@testable import Element
/**
 * Commit creation dialog view
 */
class CommitDialogView:TitleView{
    var repoTextInput:TextInput?//TODO: ⚠️️ make lazy
    var titleTextInput:TextInput?//TODO: ⚠️️ make lazy
    var descTextInput:TextInput?//TODO: ⚠️️ make lazy
    private var okButton:TextButton?//TODO: ⚠️️ make lazy
    private var cancelButton:TextButton?//TODO: ⚠️️ make lazy
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","Review local version","Review remote version","Review mix of both versions"]
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "commitDialog")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea.setTextValue("Commit message:")
        createGUI()
        //Swift.print(ElementParser.stackString(self))
    }
    /**
     *
     */
    func createGUI(){
        let guiContainer = addSubView(Container(frame.size.width,frame.size.height,self,"gui"))
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "topRuler"))
        
        //Repository: Element - iOS
        repoTextInput = guiContainer.addSubView(TextInput(width, 32, "Repository: ", "Element - iOS", guiContainer,"repo"))
        //Title:[Added Auto-fill when drawing rect]
        titleTextInput = guiContainer.addSubView(TextInput(width, 32, "Commit title: ", "Added support for padding", guiContainer,"title"))
        //Description: [multiline 300x200 TextArea]
        descTextInput = guiContainer.addSubView(TextInput(width, 32, "Commit description: ", "4 Files changed", guiContainer,"desc"))
        //Ok,Cancel buttons
        
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "ruler"))
        
        let confirmSection:Section = guiContainer.addSubView(Section(NaN,NaN,guiContainer,"confirm"))
        okButton = confirmSection.addSubView(TextButton(NaN,NaN,"OK",confirmSection,"ok"))//ok button
        cancelButton = confirmSection.addSubView(TextButton(NaN,NaN,"Cancel",confirmSection,"cancel"))//cancel button (stops the sync)
    }
    
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
