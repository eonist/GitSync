import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    lazy var nameTextInput:Text = {
        let nameTextInput = self.addSubView(Text(NaN,NaN,"Name: ",self,"name"))
        nameTextInput.isInteractive = false
        return nameTextInput
    }()
    override func resolveSkin() {
        Swift.print("RepoDetailView.resolveSkin()")
        super.resolveSkin()// self.skin = SkinResolver.skin(self)//
        _ = nameTextInput
    }
}
