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
//        Swift.print("CommitDialogView.onEvent")
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
        Swift.print("CommitDialogView.setData")
        Swift.print("repoItem.title: " + "\(repoItem.title)")
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
        Swift.print("commitMessage.title: " + "\(commitMessage.title)")
        Swift.print("commitMessage.description: " + "\(commitMessage.description)")
        StyleTestView.shared.currentPrompt?.removeFromSuperview()//remove promptView from window
        bg.async {
            GitSync.initCommit(self.repoItem!, commitMessage, {main.async{AutoSync.shared.incrementCountForRepoWithMSG()}})
        }
    }
}
