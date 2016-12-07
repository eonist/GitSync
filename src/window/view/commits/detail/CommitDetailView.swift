import Foundation
/**
 * Enables you to view the commit title and commit description of a single commit
 */
class CommitDetailView:Element {
    var titleText:Text?
    var descText:Text?
    override func resolveSkin() {
        Swift.print("CommitDetailView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        titleText = addSubView(Text(280,24,"commit title",self,"title"))
        titleText!.isInteractive = false
        descText = addSubView(Text(180,50,"commit desc",self,"description"))
        descText!.isInteractive = false
    }
    /**
     * Populates the UI elements with data
     */
    func setCommitData(commitData:Dictionary<String,String>){
        titleText!.setText(commitData["title"]!)
        descText!.setText(commitData["desc"]!)
    }
}