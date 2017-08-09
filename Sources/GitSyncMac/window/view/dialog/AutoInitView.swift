import Cocoa
@testable import Utils
@testable import Element

class AutoInitView:Element,UnFoldable{
    override func resolveSkin() {
        Swift.print("AutoInitView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"autoInitView",self)
        Swift.print("unfold completed")
        
//        self.apply([Key.issue,Text.Key.text], "Conflict: Local file is older than the remote file")
//        self.apply([Key.file,Text.Key.text], "File: AppDelegate.swift")
        
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }
    }
}
extension AutoInitView{
    func setData(_ conflict:AutoInitConflict){
        Swift.print("MergeConflictView.setData")
        self.apply([Key.issue], conflict.conflict.issue)
        self.apply([Key.proposal], conflict.proposal)
    }
    enum Key{
        static let issue = "issueText"
        static let proposal = "proposalText"
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        Swift.print("onOKButtonClick")
    }
}

struct AutoInitConflict{
//
    let pathExists:Bool
    let isGitRepo:Bool
    let hasPathContent:Bool//TODO: ⚠️️ make priv get pub set
    let conflict:(issue:String,proposal:String)
    let repoItem:RepoItem!
    lazy var isGitRepo: Bool = {
        return GitAsserter.isGitRepo(repoItem.localPath)
    }()
    init(pathExists:Bool,isGitRepo:Bool,hasPathContent:Bool){
        
        self.pathExists = FileAsserter.exists(repoItem.localPath)
        Swift.print("pathExists: " + "\(pathExists)")
        self.isGitRepo = pathExists &&
        self.hasPathContent =
        
        
        self.pathExists = pathExists
        self.isGitRepo = isGitRepo
        self.hasPathContent = hasPathContent
        self.conflict = self.generateConflict()
    }
}
extension AutoInitConflict{
    static let dummyData:AutoInitConflict = {
//        let issue:String = "There is no folder in the file path: ~/dev/demo3"
//        let proposal:String = "Do you want to create it and download from remote?"
        return AutoInitConflict(pathExists:false,isGitRepo:false,hasPathContent:false)
    }()
    /**
     *
     */
    func generateConflict() -> (issue:String,proposal:String){
    
        var issue:String = ""
        var proposal:String = ""
        if pathExists == false {
            issue = "There is no folder in the file path"
            proposal = ""
            //: ~/dev/demo3, do you want to create it and download from remote? OK, Cancel
        }else if pathExists && hasPathContent == false{
            //There is no content in the file path: ~/dev/demo3, do you want to download from remote? OK, Cancel
        }else if pathExists{
            //There is preExisiting files in path: ~/dev/demo3, do you want to download from remote and initiate a merge dialog
        }
        return (issue,proposal)
        
    }
    
    
    
}

