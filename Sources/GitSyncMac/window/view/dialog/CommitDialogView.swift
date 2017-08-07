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
    /**
     * TODO: ⚠️️ this should be possible to abstract into an universal util metod for all Unfoldables
     */
    
    //id
    var data:[String:Any] {
        get{
            var data:[String:Any] = [:]
            data[ID.repo] = ""
            data[ID.title] = UnFoldUtils.retrieveData(self, ID.title)![TextInput.Key.inputText]
            data[ID.desc] = UnFoldUtils.retrieveData(self, ID.desc)![TextInput.Key.inputText]
            return data
        }
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
    /**
     * New
     */
    func setData(_ repoItem:RepoItem, _ commitMessage:CommitMessage){
        self.repoItem = repoItem
        self.data = ID.getData(repoItem.title, commitMessage.title, commitMessage.description)
    }
    
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
        guard let title:String = data[ID.title] as? String,
            let desc:String = data[ID.title] as? String else{
                fatalError("something went wrong")
        }
        let commitMessage = CommitMessage(title,desc)
        Swift.print("commitMessage.title: " + "\(commitMessage.title)")
        Swift.print("commitMessage.description: " + "\(commitMessage.description)")
        bg.async {
            GitSync.initCommit(self.repoItem!, commitMessage:commitMessage, AutoSync.shared.incrementCountForRepoWithMSG)
        }
        
//      Nav.setView(.main(.commit))
        if let curPrompt = StyleTestView.shared.currentPrompt {curPrompt.removeFromSuperview()}//remove promptView from window
    }
    enum ID{
        static let repo = "repo"
        static let title = "title"
        static let desc = "desc"
        /**
         * New,convenient
         * TODO: ⚠️️ this should be possible to abstract into an universal util metod for all Unfoldables
         */
        static func getData(_ repoTitle:String,_ commitTitle:String,_ commitDescription:String) -> [String:[String:Any]]{
            let data:[String:[String:Any]] = [
                ID.repo:[TextInput.Key.inputText:repoTitle],//TODO:⚠️️    make inputText a const
                ID.title:[TextInput.Key.inputText:commitTitle],
                ID.desc:[TextInput.Key.inputText:commitDescription]
            ]
            return data
        }
    }
}
