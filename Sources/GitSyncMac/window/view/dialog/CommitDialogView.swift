import Foundation
@testable import Utils
@testable import Element
/**
 * TODO: ⚠️️ Set the AppMenu to only have quit
 * TODO: Somehow hide the sidemenu
 */
class CommitDialogView:Element,UnFoldable {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"commitDialogView",self)
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
}
