import Foundation
@testable import Utils
@testable import Element

class MergeConflictView:Element,UnFoldable{
    override func resolveSkin() {
        Swift.print("MergeConflictView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"mergeConflictView",self)
        Swift.print("unfold completed")
        
        self.apply([Key.issue,Text.Key.text], "Conflict: Local file is older than the remote file")
        self.apply([Key.file,Text.Key.text], "File: AppDelegate.swift")
        self.apply([Key.repo,Text.Key.text], "Repository: Element - iOS")
    }
    override func onEvent(_ event:Event) {
        //
    }
}
extension MergeConflictView{
    enum Key{
        static let issue = "issueText"
        static let file = "fileText"
        static let repo = "repoText"
    }
}
