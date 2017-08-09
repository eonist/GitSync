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
   
//    let conflict:(issue:String,proposal:String)
    let repoItem:RepoItem
   
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
        
        
//        self.pathExists = pathExists
//        self.isGitRepo = isGitRepo
//        self.hasPathContent = hasPathContent
//        self.conflict = self.generateConflict()
    }
}
extension AutoInitConflict{
    var pathExists:Bool {
        return FileAsserter.exists(repoItem.localPath)
    }
    var isGitRepo:Bool {
        return GitAsserter.isGitRepo(repoItem.localPath)
    }
    
    var hasPathContent:Bool {
        return FileAsserter.hasContent(repoItem.localPath)
    }//TODO: ⚠️️ make priv get pub set
    static let dummyData:AutoInitConflict = {
//        let issue:String = "There is no folder in the file path: ~/dev/demo3"
//        let proposal:String = "Do you want to create it and download from remote?"
        return AutoInitConflict(RepoItem(local: "~/dev/demo",branch: "master",title: "demo")/*pathExists:false,isGitRepo:false,hasPathContent:false*/)
    }()
    /**
     * New
     */
    func generateConflict() -> (issue:String,proposal:String){
        var issue:String = ""
        var proposal:String = ""
        let pathExists = self.pathExists
        if pathExists == false {
            issue = "There is no folder in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to create it and download from remote?"
            return (issue,proposal)
        }
        let hasPathContent = self.hasPathContent
        if pathExists && hasPathContent == false{
            issue = "There is no content in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote?"
            return (issue,proposal)
        }
        if pathExists && hasPathContent{
            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote and initiate a merge wizard?"
            return (issue,proposal)
        }else{
            fatalError("this case cant happen")
        }
        
    }
}

