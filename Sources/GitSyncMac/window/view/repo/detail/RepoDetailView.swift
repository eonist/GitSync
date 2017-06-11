import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    lazy var repoNameText:Text = {
        let repoNameText = self.addSubView(Text(NaN,NaN,"repo name",self,"repoName"))
        repoNameText.isInteractive = false
        return repoNameText
    }()
    override func resolveSkin() {
        Swift.print("RepoDetailView.resolveSkin()")
        super.resolveSkin()// self.skin = SkinResolver.skin(self)//
        _ = repoNameText
    }
}
