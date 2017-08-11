import Cocoa
@testable import Utils
@testable import Element

class AutoInitView:Element,UnFoldable{//TODO:⚠️️ rename to AutoInitDialog
    typealias Complete = () -> Void
    var onComplete:() -> Void = {fatalError("Please assign handler")}
    var conflict:AutoInitConflict?
    override func resolveSkin() {
        Swift.print("AutoInitView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"autoInitView",self)
        Swift.print("AutoInitView.unfold completed")
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }
    }
}
extension AutoInitView{
    func setData(_ conflict:AutoInitConflict, _ onComplete:@escaping Complete){
        Swift.print("AutoInitView.setData")
        self.onComplete = onComplete
        self.conflict = conflict
        let conflictText = AutoInitConflictUtils.text(conflict)//creates the text for the window
        self.apply([Key.issue], conflictText.issue)
        self.apply([Key.proposal], conflictText.proposal)
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
        guard let conflict = conflict else {return}
        AutoInitConflictUtils.process(conflict)//executes the git commands
        onComplete()//all done return to caller

        self.removeFromSuperview()
    }
}


