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
        self.apply([Key.issue], conflict.issue)
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
    let issue:String,proposal:String
}
extension AutoInitConflict{
    static let dummyData:AutoInitConflict = {
        let issue:String = "There is no folder in the file path: ~/dev/demo3"
        let proposal:String = "Do you want to create it and download from remote?"
        return AutoInitConflict(issue: issue, proposal:proposal)
    }()
}

