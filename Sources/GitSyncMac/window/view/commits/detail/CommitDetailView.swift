import Foundation
@testable import Utils
@testable import Element
/**
 * Enables you to view the commit title and commit description of a single commit
 */
class CommitDetailView:Element {
    var repoNameText:Text?
    var titleText:Text?
    var descText:Text?
    override func resolveSkin() {
        Swift.print("CommitDetailView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        repoNameText = addSubView(Text(120,20,"repo name",self,"repoName"))
        repoNameText!.isInteractive = false
        titleText = addSubView(Text(280,24,"commit title",self,"title"))
        titleText!.isInteractive = false
        descText = addSubView(Text(480,220,"commit desc",self,"description"))
        descText!.isInteractive = false
    }
    /**
     * Populates the UI elements with data
     */
    func setCommitData(_ commitData:[String:String]){
        repoNameText!.setText(commitData["repo-name"]!)
        titleText!.setText(commitData["title"]!)
        descText!.setText(commitData["description"]!)
    }
}
