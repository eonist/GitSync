import Cocoa
@testable import Utils
@testable import Element

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
        self.repoItem = repoItem
        self.apply([Key.repo,TextInput.Key.inputText],repoItem.title)
        self.apply([Key.title,TextInput.Key.inputText],commitMessage.title)
        self.apply([Key.desc,TextInput.Key.inputText],commitMessage.description)
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        guard let repoItem = self.repoItem else {fatalError("repoItem must be available")}
        //⚠️️ use do catch on the bellow
        guard let title:String = try? self.retrieve([Key.title,TextInput.Key.inputText]) else { fatalError("error - must have title") }
        guard let desc:String = try? self.retrieve([Key.desc,TextInput.Key.inputText]) else {fatalError("error - must have description")}
        let commitMessage = CommitMessage(title,desc)
        
        bg.async {
            GitSync.initCommit(repoItem, commitMessage, {main.async{self.onCommitDialogComplete()}})
        }
        Proxy.styleTestView?.currentPrompt?.removeFromSuperview()/*removes promptView from window*/
        
    }
}
