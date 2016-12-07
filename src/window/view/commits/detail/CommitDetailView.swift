import Foundation

class CommitDetailView:Element {
    var titleText:Text?
    var descText:Text?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        titleText = addSubView(Text(280,24,"commit title",self,"title"))
        titleText!.isInteractive = false
        descText = addSubView(Text(180,50,"commit desc",self,"description"))
        descText!.isInteractive = false
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    func setCommitData(commitData:Dictionary<String,String>){
        titleText!.setText(commitData["title"]!)
        descText!.setText(commitData["desc"]!)
    }
}