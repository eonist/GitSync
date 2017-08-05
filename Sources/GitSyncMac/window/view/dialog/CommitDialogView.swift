import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element,UnFoldable {
    override func resolveSkin() {
        Swift.print("CommitDialogView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"commitDialogView",self)
        let data:[String:[String:Any]] = [
            "repo":["inputText":"Element iOS"],
            "title":["inputText":"Added support for padding"],
            "desc":["inputText":"4 Files changed"]
        ]
        self.data = data
    }
    var data:[String:Any] {
        get{fatalError("not avialbe")}
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
    override func onEvent(_ event: Event) {
        if event.type == ButtonEvent.upInside{
            Swift.print("event.origin: " + "\(event.origin)")
        }
    }
}
