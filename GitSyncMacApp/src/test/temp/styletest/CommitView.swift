import Foundation
@testable import Element
@testable import Utils
@testable import GitSyncMac

class CommitView:Element{
    static var selectedIdx:Int = 1
    /*static let w:CGFloat = MainView.w
     static let h:CGFloat = MainView.h-48*/
    lazy var list:CommitsList = {
        let dp = CommitDPCache.read()/*Creates the dp based on cached data from previous app runs*/
        let list = self.addSubView(CommitsList.init(/*use NaN here*/self.getWidth(), self.getHeight(), CGSize(24,102), dp, self,"commitsList"))/*24 should be allowed to be nan no?*/
        //⚠️️list!.selectAt(dpIdx: CommitsView.selectedIdx)
        return list
    }()
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //topBar = addSubView(CommitsTopBar(width-12,36,self))
        //add a container
        _ = list/*creates the GUI List*/
    }
    /**
     * Eventhandler when a CommitsListItem is clicked
     */
    func onListSelect(_ event:ListEvent){
        Swift.print("CommitView.onListSelect()")
        
        //RepoView.selectedListItemIndex = list!.selectedIndex
        CommitView.selectedIdx = list.selectedIdx!
        
        Swift.print("event.index: " + "\(event.index)")
        let commitData:[String:String] = list.dp.getItemAt(event.index)!
        //(Navigation.currentView as! CommitDetailView).setCommitData(commitData)//updates the UI elements with the selected commit item
        Nav.setView(.commitDetail(commitData))
    }
    override func onEvent(_ event:Event) {
        if(event.type == ListEvent.select){onListSelect(event as! ListEvent)}
        //else {super.onEvent(event)}//forward other events
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        Swift.print("CommitView.width: " + "\(width)")
        Swift.print("list.frame.width: " + "\(list.frame.width)")
        /*Swift.print("list.contentContainer.frame.width: " + "\(list.contentContainer.frame.width)")
         Swift.print("list.rbContainer.frame.width: " + "\(list.rbContainer?.frame.width)")*/
        super.setSize(width, height)
    }
}
