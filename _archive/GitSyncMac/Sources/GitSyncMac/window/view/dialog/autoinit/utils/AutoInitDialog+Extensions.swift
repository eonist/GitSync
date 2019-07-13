import Foundation

extension AutoInitView{
    func setData(_ conflict:AutoInitConflict, _ onComplete:@escaping Complete){
        Swift.print("AutoInitView.setData: repoItem: \(conflict.repoItem)")
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
        guard let conflict = conflict else { fatalError("err") }
        AutoInitConflictUtils.process(conflict)//executes the git commands
        onComplete(conflict.repoItem, true)/*All done return to caller*/
        self.removeFromSuperview()
    }
}
