import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac
/**
 * 
 */
class RepoView2:Element {
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
    }
    override func getClassType() -> String {
        return "\(RepoView.self)"
    }
}
