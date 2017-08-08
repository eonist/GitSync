import Foundation
@testable import Utils
@testable import Element
/**
 * TODO: ⚠️️ Rename to CommitPromptView?
 */
class CommitDialogView:Element,UnFoldable {
    var repoItem:RepoItem?
    override func resolveSkin() {
        Swift.print("CommitDialogView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"commitDialogView",self)
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            Swift.print("stop the auto sync process")
            Swift.print("remove commit dialog from view")
            fatalError("not supported yet")
            //Nav.setView(.main(.commit))
        }
    }
}
extension CommitDialogView{
    enum Key{
        static let repo = "repo"
        static let title = "title"
        static let desc = "desc"
    }
    /**
     * New
     */
    func setData(_ repoItem:RepoItem, _ commitMessage:CommitMessage){
        Swift.print("setData")
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
        let desc:String = self.retrieve([Key.repo,TextInput.Key.inputText])  ?? ""
        let title:String = self.retrieve([Key.title,TextInput.Key.inputText])  ?? ""
        let commitMessage = CommitMessage(title,desc)
        Swift.print("commitMessage.title: " + "\(commitMessage.title)")
        Swift.print("commitMessage.description: " + "\(commitMessage.description)")
        bg.async {
            GitSync.initCommit(self.repoItem!, commitMessage:commitMessage, AutoSync.shared.incrementCountForRepoWithMSG)
        }
//      Nav.setView(.main(.commit))
        if let curPrompt = StyleTestView.shared.currentPrompt {curPrompt.removeFromSuperview()}//remove promptView from window
    }
    
}
