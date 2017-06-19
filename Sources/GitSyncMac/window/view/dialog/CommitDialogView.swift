import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"commitDialogView",self)
        let data:[String:[String:Any]] = [
            "repo":["inputText":"ElementiOS"],
            "title":["inputText":"Added support for padding"],
            "desc":["inputText":"4 Files changed"]
        ]
        UnFoldUtils.applyData(self, data)
    }
}
