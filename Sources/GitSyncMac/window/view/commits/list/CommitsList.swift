import Cocoa
@testable import Utils
@testable import Element

class CommitsList:ElasticSlideScrollFastList3,ICommitList{
    /*The following variables exists to facilitate the pull to refresh functionality*/
    var progressIndicator:ProgressIndicator?
    var hasPulledAndReleasedBeyondRefreshSpace:Bool = false
    var isInDeactivateRefreshModeState:Bool = false
    var isTwoFingersTouching = false/*is Two Fingers Touching the Touch-Pad*/
    var hasReleasedBeyondTop:Bool = false
    /*Debug*/
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
        let dpItem = dp.items[index]
        let item:CommitsListItem = CommitsListItem(width, itemSize.height ,dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!, false, contentContainer)
        contentContainer!.addSubview(item)
        return item
    }
    /**
     * Apply data to ListItem
     */
    override func reUse(_ listItem:FastListItem) {
        let item:CommitsListItem = listItem.item as! CommitsListItem
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        item.setData(dp.items[idx])
        if(item.selected != selected){item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.y = idx * itemSize.height/*position the item*/
    }
    override func onEvent(_ event:Event) {
        //Swift.print("CommitsList.onEvent() event.type: " + "\(event.type)")
        if(event.assert(AnimEvent.completed, progressIndicator!.animator)){
            //loopAnimationCompleted()
        }/*else if(event.assert(AnimEvent.stopped, mover!)){
            scrollAnimStopped()
        }*/
        super.onEvent(event)
        
    }
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     * //TODO: ⚠️️you need to make an scroolWheel method that you can override down hirarcy.
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("CommitsList.scrollWheel()")
        (self as ICommitList).scroll(event)
        super.scrollWheel(with: event)/*⚠️️, 👈 not good, forward the event other delegates higher up in the stack*/
    }
    /**
     *
     */
    /*func scroll(){
     Swift.print("scroll")
     }*/
     /*override func frameTick(_ value: CGFloat) {
        //Swift.print("hmm🤔")
        setProgress(value)
        //super.frameTick(value)
     }*/
    
}

extension CommitsList{
    override var moverGroup: MoverGroup?
}
