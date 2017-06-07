import Foundation
@testable import Utils
@testable import Element
/**
 * Enables you to view the commit title and commit description of a single commit
 */
class CommitDetailView:Element {
    lazy var repoNameText:Text = {
        let repoNameText = self.addSubView(Text(NaN,NaN,"repo name",self,"repoName"))
        repoNameText.isInteractive = false
        return repoNameText
    }()
    lazy var titleText:Text = {
        let titleText = self.addSubView(Text(NaN,NaN,"commit title",self,"title"))
        titleText.isInteractive = false
        return titleText
    }()
    lazy var descText:Text = {
        let descText = self.addSubView(Text(NaN,NaN,"commit desc",self,"description"))
        descText.isInteractive = false
        return descText
    }()
    override func resolveSkin() {
        Swift.print("CommitDetailView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        _ = repoNameText
        _ = titleText
        _ = descText
    }
    /**
     * Populates the UI elements with data
     */
    func setCommitData(_ commitData:[String:String]){
        repoNameText.setText(commitData["repo-name"]!)
        titleText.setText(commitData["title"]!)
        descText.setText(commitData["description"]!)
    }
}
