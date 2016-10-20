import Foundation

class ConflictDialogView:TitleView{
    private var okButton:TextButton?
    private var cancelButton:TextButton?
    //var title:String/*the title must be set after the init of the Window instance*/
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","Review local version","Review remote version","Review mix of both versions"]
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue("Resolve merge conflict:")
        /**/
        //addSubView(TextArea(NaN,NaN,"Resolve merge conflict:",self,"conflictText"))
        
        let repoText:String = "Repository: " + "Element - iOS"
        addSubView(TextArea(NaN,NaN,repoText,self,"repoText"))
        
        let fileText:String = "File: " + "AppDelegate.swift"
        addSubView(TextArea(NaN,NaN,fileText,self,"fileText"))
        let issueText:String = "Issue: " + "Local file is older than remote"
        addSubView(TextArea(NaN,NaN,issueText,self,"issueText"))
        
        //Create 3 TextButtons (Review local,remote,mix)
        addSubView(TextButton(NaN,NaN,"Review local version",self,"reviewBtn"))
        
        addSubView(TextButton(NaN,NaN,"Review remote version",self,"reviewBtn"))
        addSubView(TextButton(NaN,NaN,"Review mix version",self,"reviewBtn"))
        /**/
        //Create 3 RadioButtons in a collumn: (keep local,remote, mix)
        
        let rb1 = addSubView(RadioButton(NaN,NaN,"keep local version",true,self))
        let rb2 = addSubView(RadioButton(NaN,NaN,"keep remote version",false,self))
        let rb3 = addSubView(RadioButton(NaN,NaN,"keep mix of both versions",false,self))
        let selectGroup:SelectGroup = SelectGroup([rb1,rb2,rb3],rb1)
        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)")
        }
        selectGroup.event = onSelectGroupChange
       
        /**/
        //A checkBoxButton:[x] apply to all conflicts in this repo's (reset after sync complete)
        
        //A checkBoxButton:[x] apply to all conflicts in all repo's (reset after sync complete)
        
        addSubView(CheckBoxButton(NaN, NaN,"Apply to all conflicts",false,self))
        addSubView(CheckBoxButton(NaN, NaN,"Apply to all repos",false,self))
        
        let confirmSection:Section = addSubView(Section(NaN,NaN,self,"confirm"))
        okButton = confirmSection.addSubView(TextButton(NaN,NaN,"OK",confirmSection,"ok"))//ok button
        cancelButton = confirmSection.addSubView(TextButton(NaN,NaN,"Cancel",confirmSection,"cancel"))//cancel button (stops the sync)
        
        /**/
        //Looping repos (happens in MainView, so that its not canceled)
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
    }
    func onOkButtonRelease(event:ButtonEvent)  {
        Swift.print("onOkButtonRelease")
    }
    func onCancelButtonRelease(event:ButtonEvent)  {
        Swift.print("onCancelButtonRelease")
    }
    func onbuttonEvent(event:Event){
        if(event.assert(ButtonEvent.upInside, okButton)){onOkButtonRelease(event.cast())}
        else if(event.type == ButtonEvent.upInside && event.origin === cancelButton){onCancelButtonRelease(event.cast())}
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}