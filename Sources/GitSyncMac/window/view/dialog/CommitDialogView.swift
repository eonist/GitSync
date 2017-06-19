import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"commitDialogView",self)
        
    }
    
}
