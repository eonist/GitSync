import Foundation

class class RepoDetailView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.app,"repoDetailView",self)
    }
}
