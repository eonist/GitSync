import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: ⚠️️ Rename to CommitPromptView?
 */
class CommitDialogView:Element,UnFoldable,Closable {
    var repoItem:RepoItem?
    var onCommitDialogComplete:Completed = {fatalError("no completion handler assigned")}/*Stores the onComplete when the user clicks OK*/
    
    override func resolveSkin() {
        Swift.print("🍊 CommitDialogView.resolveSkin()")
        super.resolveSkin()
        Unfold.unFold(fileURL: Config.Bundle.structure,path: "commitDialogView",parent: self)
        NSApp.requestUserAttention(.informationalRequest)//bounce the dock icon
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){/*stop the auto sync process,remove commit dialog from view*/
            Proxy.styleTestView?.currentPrompt?.removeFromSuperview()/*removes promptView from window*/
            self.onCommitDialogComplete()
        }
    }
}

