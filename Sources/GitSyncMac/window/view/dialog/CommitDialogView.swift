import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: ⚠️️ Rename to CommitPromptView?
 */
class CommitDialogView:Element,UnFoldable,Closable {
    var repoItem:RepoItem?
    var onCommitDialogComplete:Completed = {fatalError("no completion handler assigned")}
    
    override func resolveSkin() {
        Swift.print("CommitDialogView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"commitDialogView",self)
        NSApp.requestUserAttention(.informationalRequest)
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            Swift.print("stop the auto sync process")
            Swift.print("remove commit dialog from view")
            fatalError("not supported yet")
        }
    }
}
extension CommitDialogView{
    typealias Completed = ()->Void
    enum Key{
        static let repo = "repo"
        static let title = "title"
        static let desc = "desc"
    }
    /**
     * New
     */
    func setData(_ repoItem:RepoItem, _ commitMessage:CommitMessage, _ onCommitDialogComplete:@escaping Completed){
        self.onCommitDialogComplete = onCommitDialogComplete
//        Swift.print("CommitDialogView.setData")
//        Swift.print("repoItem.title: " + "\(repoItem.title)")
        self.repoItem = repoItem
        self.apply([Key.repo,TextInput.Key.inputText],repoItem.title)
        self.apply([Key.title,TextInput.Key.inputText],commitMessage.title)
        self.apply([Key.desc,TextInput.Key.inputText],commitMessage.description)
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
        Swift.print("onOKButtonClick")
        let title:String = self.retrieve([Key.title,TextInput.Key.inputText])  ?? {fatalError("error - must have title")}()
        let desc:String = self.retrieve([Key.desc,TextInput.Key.inputText])  ?? {fatalError("error - must have description")}()
        
        let commitMessage = CommitMessage(title,desc)
//        Swift.print("commitMessage.title: " + "\(commitMessage.title)")
//        Swift.print("commitMessage.description: " + "\(commitMessage.description)")
        Proxy.styleTestView?.currentPrompt?.removeFromSuperview()//remove promptView from window
        bg.async {
            GitSync.initCommit(self.repoItem!, commitMessage, {main.async{self.onCommitDialogComplete()}})
        }
    }
}
