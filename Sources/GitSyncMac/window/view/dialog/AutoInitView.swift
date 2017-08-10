import Cocoa
@testable import Utils
@testable import Element

class AutoInitView:Element,UnFoldable{
    typealias Complete = () -> Void
    var onComplete:() -> Void = {fatalError("Please assign handler")}
    override func resolveSkin() {
        Swift.print("AutoInitView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"autoInitView",self)
        Swift.print("AutoInitView.unfold completed")
        
        
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
            let strategy = AutoInitConflict.Strategy.strategy(pathExists: <#T##Bool#>, isGitRepo: <#T##Bool#>, hasPathContent: <#T##Bool#>)
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }
    }
}
extension AutoInitView{
    func setData(_ conflict:AutoInitConflict, _ onComplete:@escaping Complete){
        Swift.print("MergeConflictView.setData")
        self.onComplete = onComplete
        self.apply([Key.issue], conflict.conflict.issue)
        self.apply([Key.proposal], conflict.conflict.proposal)
    }
    enum Key{
        static let issue = "issueText"
        static let proposal = "proposalText"
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        Swift.print("onOKButtonClick")
        
        onComplete()
    }
}


