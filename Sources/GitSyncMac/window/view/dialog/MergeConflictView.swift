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
            "issueText":[Unfold.Text.text:repoTitle],//TODO:⚠️️    make inputText a const
            DataType.title:[Unfold.TextInput.inputText:commitTitle],
            DataType.desc:[Unfold.TextInput.inputText:commitDescription]
        ]
//        self.data = DataType.getData("Repo title", "Commit title", "Commit description")//test data
    }
    override func onEvent(_ event:Event) {
        //
    }
}
extension MergeConflictView{
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
