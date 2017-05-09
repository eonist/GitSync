import Foundation
@testable import Utils
@testable import Element
/**
 * MERGE Conflict dialog view
 * TODO: Make the review buttons as a clickable text in the keep radiobuttons. 
 * TODO: Inline the radiobuttons: Keep: (x) local, () remote, () both
 * TODO: Remove the cancel button and enable the close button again
 */
class ConflictDialogView:TitleView{
    private var okButton:TextButton?
    private var cancelButton:TextButton?
    //var title:String/*the title must be set after the init of the Window instance*/
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","Review local version","Review remote version","Review mix of both versions"]
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "conflict")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea.setTextValue("Resolve merge conflict:")
        
        createGUI()
        //Swift.print(ElementParser.stackString(self))
    }
    /**
     *
     */
    func createGUI(){
        Swift.print("createGUI()")
        Swift.print("frame.width: " + "\(frame.size.width)")
        Swift.print("frame.height: " + "\(frame.size.height)")
        let guiContainer = addSubView(Container(frame.size.width,frame.size.height,self,"gui"))
        //guiContainer.addSubView(TextArea(NaN,NaN,"Resolve merge conflict:",guiContainer,"conflictText"))
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "topRuler"))
        
        let issueText:String = "Conflict: " + "Local file is older than the remote file"
        _ = guiContainer.addSubView(TextArea(NaN,NaN,issueText,guiContainer,"issueText"))
        
        let fileText:String = "File: " + "AppDelegate.swift"
        _ = guiContainer.addSubView(TextArea(NaN,NaN,fileText,guiContainer,"fileText"))
        
        let repoText:String = "Repository: " + "Element - iOS"
        _ = guiContainer.addSubView(TextArea(NaN,NaN,repoText,guiContainer,"repoText"))
        /*
        guiContainer.addSubView(Element(NaN, NaN, guiContainer, "ruler"))
        
        //Create 3 TextButtons (Review local,remote,mix)
        guiContainer.addSubView(TextButton(NaN,NaN,"Review local version",guiContainer,"reviewBtn"))
        guiContainer.addSubView(TextButton(NaN,NaN,"Review remote version",guiContainer,"reviewBtn"))
        guiContainer.addSubView(TextButton(NaN,NaN,"Review mix version",guiContainer,"reviewBtn"))
        */
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "ruler"))
        
        //Create 3 RadioButtons in a collumn: (keep local,remote, mix)
        
        let rb1 = guiContainer.addSubView(RadioButton(NaN,24,"keep local version",true,guiContainer))/*<-- height should be NaN, but a bug prevents it from working*/
        let rb2 = guiContainer.addSubView(RadioButton(NaN,24,"keep remote version",false,guiContainer))
        let rb3 = guiContainer.addSubView(RadioButton(NaN,24,"keep mix of both versions",false,guiContainer))
        let selectGroup:SelectGroup = SelectGroup([rb1,rb2,rb3],rb1)
        
        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)")
        }
        selectGroup.event = onSelectGroupChange
        
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "ruler"))
        
        //A checkBoxButton:[x] apply to all conflicts in this repo's (reset after sync complete)
        
        //A checkBoxButton:[x] apply to all conflicts in all repo's (reset after sync complete)
        
        _ = guiContainer.addSubView(CheckBoxButton(NaN, NaN,"Apply to all conflicts",false,guiContainer))
        _ = guiContainer.addSubView(CheckBoxButton(NaN, NaN,"Apply to all repos",false,guiContainer))
        
        _ = guiContainer.addSubView(Element(NaN, NaN, guiContainer, "ruler"))
        
        let confirmSection:Section = guiContainer.addSubView(Section(NaN,NaN,guiContainer,"confirm"))
        okButton = confirmSection.addSubView(TextButton(NaN,NaN,"OK",confirmSection,"ok"))//ok button
        cancelButton = confirmSection.addSubView(TextButton(NaN,NaN,"Cancel",confirmSection,"cancel"))//cancel button (stops the sync)
        
        /**/
        //Looping repos (happens in MainView, so that it's not canceled)
        //create a static array of repos
        //when an repo is "synced" remove it from the array
        //sync(repos[0])
        //if(sync has conflict)
        //conflictResolutionPopUp()
        
        //when you click ok:
        //Alter static class var's (conflictSolved = true)//remember to reset this
        //init looping the static repo list
        //Navigate.setView(CommitView)
        
        //when you click cancel:
        //empty the syncRepoList in MainView
        //restart timer
        //Navigate.setView(CommitView)
        /**/
        
        Swift.print("createGUI - complete")
    }
    func onOkButtonRelease(_ event:ButtonEvent)  {
        Swift.print("onOkButtonRelease")
    }
    func onCancelButtonRelease(_ event:ButtonEvent)  {
        Swift.print("onCancelButtonRelease")
    }
    func onbuttonEvent(_ event:Event){
        if(event.assert(ButtonEvent.upInside, okButton)){onOkButtonRelease(event.cast())}
        else if(event.type == ButtonEvent.upInside && event.origin === cancelButton){onCancelButtonRelease(event.cast())}
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
