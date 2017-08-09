import Cocoa
@testable import Utils
@testable import Element

class AutoInitView:Element,UnFoldable{
    override func resolveSkin() {
        Swift.print("MergeConflictView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"mergeConflictView",self)
        Swift.print("unfold completed")
        
        self.apply([Key.issue,Text.Key.text], "Conflict: Local file is older than the remote file")
        self.apply([Key.file,Text.Key.text], "File: AppDelegate.swift")
        self.apply([Key.repo,Text.Key.text], "Repository: Element - iOS")
        
        _ = radioButtonGroup
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }/*else if event.assert(SelectEvent.select){
         
         }*/
    }

}
extension AutoInitView{
    func setData(_ mergeConflict:MergeConflict){
        Swift.print("MergeConflictView.setData")
        self.apply([Key.issue], mergeConflict.issue)
        self.apply([Key.file], mergeConflict.file)
        self.apply([Key.repo], mergeConflict.repo)
    }
    enum Key{
        static let issue = "issueText"
        static let file = "fileText"
        static let repo = "repoText"
        static let keepLocal = "keepLocalVersion"
        static let keepRemote = "keepRemoteVersion"
        static let keepMixed = "keepMixedVersion"
        static let applyAllConflicts = "applyAllConflicts"
        static let applyAllRepos = "applyAllRepos"
    }
    func onSelectGroupChange(event:Event){
        Swift.print("onSelectGroupChange event.selectable: " + "\(event)")
    }
    func onCheckGroupChange(event:Event){/*this is the event handler*/
        Swift.print("onSelectGroupChange event.selectable: " + "\(event)")
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        Swift.print("onOKButtonClick")
    }
}


//There is no folder in the file path: ~/dev/demo3, do you want to create it and download from remote? OK, Cancel
//There is no content in the file path: ~/dev/demo3, do you want to download from remote? OK, Cancel
//There is preExisiting files in path: ~/dev/demo3, do you want to download from remote and initiate a merge dialog

struct AutoInitConflict{
    let issue:String,file:String,repo:String
}
extension AutoInitConflict{
    static let dummyData:MergeConflict = {
        let issue:String = "Conflict: Local file is older than the remote file"
        let file:String = "File: Element.swift"
        let repo:String = "Repository: Element - iOS"
        return MergeConflict(issue: issue, file: file, repo: repo)
    }()
}

