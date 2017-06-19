import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"commitDialogView",self)
        
    }
    var data:[String:Any]{
        get{fatalError("not avilable")}
        set{
            
            var repo:TextInput? {return self.element("repo")}
            var title:TextInput? {return self.element("title")}
            var desc:TextInput? {return self.element("desc")}
            
        }
    }
}
