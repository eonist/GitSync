import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"commitDialogView",self)
        
    }
    /*var data:[String:Any]{
        get{fatalError("not avilable")}
        set{
            
            if let repo:TextInput? = self.element("repo"), let repoText {
                
            }
            var title:TextInput? {return self.element("title")}
            var desc:TextInput? {return self.element("desc")}
            
        }
    }*/
}
