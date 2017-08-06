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
        self.data = DataType.getData("Repo title", "Commit title", "Commit description")//test data
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            Swift.print("do commit stuff here")
            Swift.print("remove commit dialog from view")
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
    var data:[String:Any] {
        get{
            var data:[String:Any] = [:]
            data[DataType.repo] = ""
            data[DataType.title] = UnFoldUtils.retrieveData(self, DataType.title)![Unfold.TextInput.inputText]
            data[DataType.desc] = UnFoldUtils.retrieveData(self, DataType.desc)![Unfold.TextInput.inputText]
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
        self.data = DataType.getData(repoItem.title, commitMessage.title, commitMessage.description)
    }
    
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
        guard let title:String = data[DataType.title] as? String,
            let desc:String = data[DataType.title] as? String else{
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
    enum DataType{
        static let repo = "repo"
        static let title = "title"
        static let desc = "desc"
        /**
         * New,convenient
         * TODO: ⚠️️ this should be possible to abstract into an universal util metod for all Unfoldables
         */
        static func getData(_ repoTitle:String,_ commitTitle:String,_ commitDescription:String) -> [String:[String:Any]]{
            let data:[String:[String:Any]] = [
                DataType.repo:[Unfold.TextInput.inputText:repoTitle],//TODO:⚠️️    make inputText a const
                DataType.title:[Unfold.TextInput.inputText:commitTitle],
                DataType.desc:[Unfold.TextInput.inputText:commitDescription]
            ]
            return data
        }
    }
}
