import Foundation

class CommitDetailView:Element {
    var titleText:Text?
    var descText:Text?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        titleText = addSubView(Text(280,24,title,container,"title"))
        titleText!.isInteractive = false
        descText = container.addSubView(Text(180,50,desc,container,"description"))
        descText!.isInteractive = false
    }
}
