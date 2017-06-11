import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    override func resolveSkin() {
        Swift.print("RepoDetailView.resolveSkin()")
        super.resolveSkin()//self.skin = SkinResolver.skin(self)
        _ = addSubView(TextInput(width, NaN, "Name: ", "Test", self,""))
    }
}
