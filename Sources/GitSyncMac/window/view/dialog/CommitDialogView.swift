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
     * TODO: ⚠️️ this should be possible to abstract into an universal util metod for all Unfoldables
     */
    var data:[String:Any] {
        get{fatalError("error")
        }set{fatalError("error")}
    }
    /**
     * New
     */
    func setData(_ repoItem:RepoItem, _ commitMessage:CommitMessage){
        self.repoItem = repoItem
//        ID.repo:[:repoTitle],//TODO:⚠️️    make inputText a const
//        ID.title:[TextInput.Key.inputText:commitTitle],
//        ID.desc:[TextInput.Key.inputText:commitDescription]
        
        UnFoldUtils.applyData(self,[Key.repo,TextInput.Key.inputText],repoItem.title)
        //self.data = ID.getData(, commitMessage.title, commitMessage.description)
    }
    
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
//        let title:String = UnFoldUtils.retrieve(self, [Key.repo]).
        //let desc:String = UnFoldUtils.retrive(Key.repo,TextInput.Key.inputText])
        guard let desc:String = UnFoldUtils.retrieve(self, [Key.repo,TextInput.Key.inputText]) else{fatalError("error")}
        guard let title:String = UnFoldUtils.retrieve(self, [Key.title,TextInput.Key.inputText]) else{fatalError("error")}

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
