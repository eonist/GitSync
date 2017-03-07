import Cocoa
@testable import Utils
@testable import Element

class CommitsList:RBSliderFastList,ICommitList{
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
    
    //TODO:move into extension
    
    func scrollAnimStopped(){
        Swift.print(" CommitsList.scrollAnimStopped()")
        defaultScrollAnimStopped()
        if(isInDeactivateRefreshModeState){
            //Swift.print("reset refreshState")
            hasPulledAndReleasedBeyondRefreshSpace = false//reset
            isInDeactivateRefreshModeState = false//reset
        }
        fatalError("debug")
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
    override func setProgress(_ value:CGFloat) {
        super.setProgress(value)
        onProgress()
    }
}
protocol ICommitList:IRBSlidable{
    var isTwoFingersTouching:Bool {get set}
    var progressIndicator:ProgressIndicator? {get set}
    var hasPulledAndReleasedBeyondRefreshSpace:Bool{get set}
    var hasReleasedBeyondTop:Bool {get set}
    var autoSyncAndRefreshStartTime:NSDate? {get set}
    func startAutoSync()
    /*fast list related*/
    func reUseAll()
    func reUse(_ listItem:FastListItem)
}
extension ICommitList{
    func scrollWheelEnter() {
        Swift.print("CommitsList.scrollWheelEnter")
        reUseAll()/*Refresh*/
        isTwoFingersTouching = true
        defaultScrollWheelEnter()
    }
    func scrollWheelExit(){
        Swift.print("CommitList.scrollWheelExit()")
        isTwoFingersTouching = false
        let value = mover!.result
        if(value > 60){
            //Swift.print("start animation the ProgressIndicator")
            mover!.frame.y = 60
            progressIndicator!.start()//1. start spinning the progressIndicator
            hasPulledAndReleasedBeyondRefreshSpace = true
            autoSyncAndRefreshStartTime = NSDate()//init debug timer
            startAutoSync()/*🚪⬅️️ <- starts the process of downloading commits here*/
        }else if (value > 0){
            hasReleasedBeyondTop = true
            //scrollController!.mover.topMargin = 0
        }else{
            hasReleasedBeyondTop = false
        }
    }
}
extension CommitsList{
    /**
     * Starts the auto sync process
     */
    func startAutoSync(){
        let refresh = Refresh(dp as! CommitDP)/*attach the dp that RBSliderFastList uses*/
        refresh.onComplete = loopAnimationCompleted // Attach the refresh.completion handler here
        autoSyncStartTime = NSDate()
        func onComplete(){
            Swift.print("⏳ All 🔨 & 🚀 " + "\(abs(autoSyncStartTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
            refresh.initRefresh()
        }
        AutoSync.initSync(onComplete)/* start the refresh process when AutoSync.onComplete is fired off*/
    }
    /**
     * Basically not in refreshState
     */
    func loopAnimationCompleted(){
        //Swift.print("CommitList.loopAnimationCompleted()")
        reUseAll()/*Refresh*/
        progressIndicator!.progress(0)
        progressIndicator!.stop()
        isInDeactivateRefreshModeState = true
        mover!.frame.y = 0
        mover!.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        mover!.start()
        //progressIndicator!.reveal(0)//reset all line alphas to 0
        Swift.print("🏁 AutoSync™ completed \(abs(autoSyncAndRefreshStartTime!.timeIntervalSinceNow))")
    }
    /**
     * Happens when you use the scrollwheel or use the slider (also works while there still is momentum) (This content of this method could be inside setProgress, but its easier to reason with if it is its own method)
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onProgress(){
        let value = mover!.result
        Swift.print("CommitsList.onProgress() mover!.result: \(mover!.result) progressValue: \(progressValue!)  hasPulledAndReleasedBeyondRefreshSpace: \(hasPulledAndReleasedBeyondRefreshSpace) isTwoFingersTouching \(isTwoFingersTouching)")
        Swift.print("value: " + "\(value)")
        if(value >  0 && value < 60){//between 0 and 60
            //Swift.print("start progressing the ProgressIndicator")
            let scalarVal:CGFloat = value / 60//0 to 1 (value settle on near 0)
            if(hasPulledAndReleasedBeyondRefreshSpace){//isInRefreshMode
                progressIndicator!.frame.y = -45 + (scalarVal * 60)
            }else if(isTwoFingersTouching || hasReleasedBeyondTop){
                progressIndicator!.frame.y = 15//<--this could be set else where but something kept interfering with it
                progressIndicator!.reveal(scalarVal)//the progress indicator needs to be able to be able to reveal it self 1 tick at the time in the init state
            }
        }else if(value > 60){
            progressIndicator!.frame.y = 15
        }
    }
}
