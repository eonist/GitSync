import Foundation
@testable import Element
@testable import Utils

class CommitView:Element{
    static var selectedIdx:Int = 1
    lazy var list:CommitsList = self.createCommitList()
    var commitDetailView:CommitDetailView?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        _ = list/*creates the GUI List*/
    }
    /**
     * EventHandler when a CommitsListItem is clicked
     */
    func onListSelect(_ event:ListEvent){
        Swift.print("CommitView.onListSelect()")
        CommitView.selectedIdx = list.selectedIdx!
        Swift.print("event.index: " + "\(event.index)")
        let commitData:[String:String] = list.dp.getItemAt(event.index)!
        Nav.setView(.detail(.commit(commitData)))
    }
    override func onEvent(_ event:Event) {
        if event.type == ListEvent.select {onListSelect(event as! ListEvent)}
        //else {super.onEvent(event)}//forward other events
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        Swift.print("CommitView.width: " + "\(width)")
        Swift.print("list.frame.width: " + "\(list.frame.width)")
        Swift.print("list.contentContainer.width: " + "\(list.contentContainer.width)")
        
        //Swift.print("list.rbContainer.width: " + "\(list.rbContainer)")
        /*Swift.print("list.contentContainer.frame.width: " + "\(list.contentContainer.frame.width)")
         */
        super.setSize(width, height)
    }
}
extension CommitView{
    /**
     *
     */
    func createCommitList() -> CommitsList{
        let dp = CommitDPCache.read()/*Creates the dp based on cached data from previous app runs*/
        let list = self.addSubView(CommitsList.init(self.getWidth(), self.getHeight(), CGSize(24,102), dp, self,"commitsList"))/*24 should be allowed to be nan no?*/
        //⚠️️list!.selectAt(dpIdx: CommitsView.selectedIdx)
        return list
    }
}
