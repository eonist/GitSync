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
        get{
            fatalError("error")
//            var data:[String:Any] = [:]
//            UnFoldUtils.retrieve(self, [ID.title])
            
        }set{
//            if let data = newValue as? [String:[String:Any]] {
//                UnFoldUtils.applyData(self, data)
//            }
            fatalError("error")
        }
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
        //let desc:String =
        if let data = UnFoldUtils.retrieveData(self, [Key.repo,]) let  {
            //[TextInput.Key.inputText]
        }
//        guard let title:String = data[Key.title] as? String,let desc:String = data[Key.title] as? String else{
//            fatalError("something went wrong")
//        }
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
