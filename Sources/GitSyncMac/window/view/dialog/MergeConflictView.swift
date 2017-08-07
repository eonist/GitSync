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
            ID.issue:[Text.Key.text:"Conflict: Local file is older than the remote file"],
            ID.file:[Text.Key.text:"File: AppDelegate.swift"],
            ID.repo:[Text.Key.text:"Repository: Element - iOS"]
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
    /**
     *
     */
    func setData(){
        
    }
    var data:[String:Any] {
        get{
            fatalError("not yet")
        }
        set{
            fatalError("error")
//            if let data = newValue as? [String:[String:Any]] {
//                UnFoldUtils.applyData(self, data)
//            }
        }
    }
}
