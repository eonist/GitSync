import Foundation
@testable import Utils
@testable import Element

class MergeConflictView:Element,UnFoldable{
    override func resolveSkin() {
        Swift.print("MergeConflictView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"mergeConflictView",self)
        Swift.print("unfold completed")
        let data:[String:[String:Any]] = [
            ID.issue:[Unfold.Text.text:"Conflict: Local file is older than the remote file"],
            ID.file:[Unfold.Text.text:"File: AppDelegate.swift"],
            ID.repo:[Unfold.Text.text:"Repository: Element - iOS"]
        ]
        self.data = data
    }
    override func onEvent(_ event:Event) {
        //
    }
}
extension MergeConflictView{
    enum ID{
        static let issue = "issueText"
        static let file = "fileText"
        static let repo = "repoText"
    }
    var data:[String:Any] {
        get{
            fatalError("not yet")
        }
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
}
