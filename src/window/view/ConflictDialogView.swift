import Foundation

class ConflictDialogView:TitleView{
    static let w:CGFloat = 220
    static let h:CGFloat = 380
    var title:String/*the title must be set after the init of the Window instance*/
    let mergeOptions:[String] = ["keep local version","keep remote version","keep mix of both versions","Review local version","Review remote version","Review mix of both versions"]
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        Swift.print("ConflictDialogView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        
        //Repository: Element - iOS
        addSubView(Text(150,24,"Repository: ",self,"repoDesc"))
        /*
        addSubView(Text(NaN,NaN,"Element - iOS",self,"repoTitle"))
        //File: ~/documents/element-ios/AppDelegate.swift
        addSubView(Text(NaN,NaN,"File: ",self,"fileDesc"))
        addSubView(Text(NaN,NaN,"~/documents/element-ios/AppDelegate.swift",self,"filePath"))
        //Issue: There is a newer remote version of this file
        addSubView(Text(NaN,NaN,"Issue: ",self,"issueDesc"))
        addSubView(Text(NaN,NaN,"There is a newer remote version of this file",self,"issueText"))
        */
        //Create 3 TextButtons (Review local,remote,mix)
        //Create 3 RadioButtons in a collumn: (keep local,remote, mix)
        //A checkBoxButton:[x] apply to all conflicts in this repo's (reset after sync complete)
        //A checkBoxButton:[x] apply to all conflicts in all repo's (reset after sync complete)
        //ok button
        //cancel button (stops the sync)
        
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
        
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}