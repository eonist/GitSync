import Cocoa
@testable import Utils
@testable import Element

class CommitsList:ElasticSlideScrollFastList,ICommitList{
    /*The following variables exists to facilitate the pull to refresh functionality*/
    var progressIndicator:ProgressIndicator?
    var hasPulledAndReleasedBeyondRefreshSpace:Bool = false
    var isInDeactivateRefreshModeState:Bool = false
    var isTwoFingersTouching = false/*is Two Fingers Touching the Touch-Pad*/
    var hasReleasedBeyondTop:Bool = false
    var autoSyncStartTime:NSDate?
    var autoSyncAndRefreshStartTime:NSDate?

    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
        progressIndicator!.frame.y = -45/*hide at init*/
        progressIndicator!.animator!.event = onEvent
    }
    /**
     * Create ListItem
     */
    override func createItem(_ index:Int) -> Element {
        //Swift.print("CommitsList.createItem index: \(index)")
        let dpItem = dataProvider.items[index]
        let item:CommitsListItem = CommitsListItem(width, itemHeight ,dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!, false, lableContainer)
        lableContainer!.addSubview(item)
        return item
    }
    /**
     * Apply data to ListItem
     */
    override func reUse(_ listItem:FastListItem) {
        //Swift.print("CommitsList.reUse: idx: " + "\(listItem.idx)")
        let item:CommitsListItem = listItem.item as! CommitsListItem
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        item.setData(dataProvider.items[idx])
        if(item.selected != selected){item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.y = idx * itemHeight/*position the item*/
    }
    override func onEvent(_ event:Event) {
        //Swift.print("CommitsList.onEvent() event.type: " + "\(event.type)")
        if(event.assert(AnimEvent.completed, progressIndicator!.animator)){
            //loopAnimationCompleted()
        }else if(event.assert(AnimEvent.stopped, mover!)){
            scrollAnimStopped()
        }
        super.onEvent(event)
    }
    func setProgress(_ value:CGFloat) {
        Swift.print("🌵 setProgress")
        super.setProgress(value)
        onProgress()
    }
}
