import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element,UnFoldable {
    enum DataType{
        static let repo = "repo"
        static let title = "title"
        static let desc = "desc"
        /**
         * New
         */
        static func getData(_ repoTitle:String,_ commitTitle:String,_ commitDescription:String) -> [String:[String:Any]]{
            let data:[String:[String:Any]] = [
                DataType.repo:[Unfold.TextInput.inputText:repoTitle],//TODO:⚠️️    make inputText a const
                DataType.title:[Unfold.TextInput.inputText:commitTitle],
                DataType.desc:[Unfold.TextInput.inputText:commitDescription]
            ]
            return data
        }
        /**
         *
         */
        static func gestData(){
            
        }
    }
    override func resolveSkin() {
        Swift.print("CommitDialogView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"commitDialogView",self)
        self.data = DataType.getData("Element iOS", "Added support for padding", "4 Files changed")//test data
    }
    var data:[String:Any] {
        get{
            return
        }
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
    var repoItem:RepoItem?
    var commitMessage:CommitMessage{
        return CommitMessage("","")
    }
    /**
     * New
     */
    func setData(_ repoItem:RepoItem, _ commitMessage:CommitMessage){
        self.data = DataType.getData(repoItem.title, commitMessage.title, commitMessage.description)
    }
  
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
        GitSync.initCommit(<#T##repoItem: RepoItem##RepoItem#>, commitMessage: <#T##CommitMessage?#>, <#T##onPushComplete: GitSync.PushComplete##GitSync.PushComplete##(Bool) -> Void#>)
        Nav.setView(.main(.commit))
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
