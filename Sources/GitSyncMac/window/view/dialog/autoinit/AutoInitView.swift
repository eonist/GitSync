import Cocoa
@testable import Utils
@testable import Element

class AutoInitView:Element,UnFoldable,Closable{
    //TODO:⚠️️ rename to AutoInitDialog
    var verifiedRepos: [RepoItem]?
    typealias Complete = (RepoItem, Bool) -> Void
    var onComplete:Complete = { (_,_) in fatalError("Please assign handler") }
    var conflict: AutoInitConflict?
    override func resolveSkin() {
        Swift.print("AutoInitView.resolveSkin()")
        super.resolveSkin()
        Unfold.unFold(fileURL: Config.Bundle.structure, path: "autoInitView", parent: self)
        Swift.print("AutoInitView.unfold completed")
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        } else if event.assert(.upInside, id: "cancel"){
            //fatalError("not yet supported: \(conflict!.repoItem)")
            self.removeFromSuperview()
            guard let conflict = conflict else { fatalError("err") }
            onComplete(conflict.repoItem, false)/*All done return to caller*/
        }
    }
}
