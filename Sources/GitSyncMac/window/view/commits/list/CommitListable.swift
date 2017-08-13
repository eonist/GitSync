import Cocoa
@testable import Utils
@testable import Element

typealias ICommitList = CommitListable
protocol CommitListable:ElasticSlidableScrollableFastListable3 {
    var progressIndicator:ProgressIndicator {get set}
    var performance:PerformanceTester {get set} /*Debug*/
    var _state:CommitListState {get set}//because state is used by Element
}
extension CommitListable{
    /**
     * TODO: ⚠️️ Comment this method
     */
    func setProgressValue(_ value:CGFloat, _ dir:Dir){/*gets called from MoverGroup*/
        if dir == .ver && _state.hasReleasedBeyondTop{
            //Swift.print("🌵 ICommitList.setProgressValue : hasReleasedBeyondTop: \(hasReleasedBeyondTop)")
            iterateProgressBar(value)
        }
        (self as ElasticSlidableScrollableFastListable3).setProgressValue(value,dir)
    }
    /**
     * TODO: ⚠️️ Comment this method
     */
    func scroll(_ event:NSEvent) {
        //Swift.print("🌵 ICommitList.scroll()")
        if event.phase == NSEventPhase.changed {//this is only direct manipulation, not momentum
            iterateProgressBar(moverGroup!.result.y)/*mover!.result*/
        }else if event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began {
            (self as ICommitList).scrollWheelEnter()
        }else if event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled {
            (self as ICommitList).scrollWheelExit()
        }
    }
    /**
     * TODO: ⚠️️ Comment this method
     */
    func scrollWheelEnter() {
        //Swift.print("🌵 ICommitsList.scrollWheelEnter")
        //reUseAll()/*Refresh*/
        _state.isTwoFingersTouching = true
    }
    /**
     * TODO: ⚠️️ Comment this method
     */
    func scrollWheelExit(){
        //Swift.print("🌵 CommitList.scrollWheelExit()")
        _state.isTwoFingersTouching = false
        let value = moverGroup!.result.y
        if value > 60{
            //Swift.print("start animation the ProgressIndicator")
            moverGroup?.yMover.frame.y = 60
            progressIndicator.start()//1. start spinning the progressIndicator
            _state.hasPulledAndReleasedBeyondRefreshThreshold = true
            startAutoSync(self.onRefreshComplete)/*🚪⬅️️ <- starts the process of downloading commits here*/
        }else if value > 0{
            _state.hasReleasedBeyondTop = true
            //scrollController!.mover.topMargin = 0
        }else{
            _state.hasReleasedBeyondTop = false
        }/**/
    }
    /**
     * Starts the auto sync process (Happens after the pull to refresh gesture)
     */
    fileprivate func startAutoSync(_ syncComplete:@escaping ()->Void){
        _ = performance.autoSyncAndRefreshStartTime//init debug timer, TODO: move this inside startAutoSync method, maybe?
        _ = performance.autoSyncStartTime/*Sets debug timer*/
        _ = AutoSync{/*⬅️️🚪 Start the refresh process when AutoSync.onComplete is fired off*/
            Swift.print("🏁🏁🏁 AutoSyncCompleted" + "\(self.performance.autoSyncStartTime.secsSinceStart)")/*How long did the gathering of git commit logs take?*/
            _ = Refresh(self.dp as! CommitDP, syncComplete)/* ⬅️️ Refresh happens after AutoSync is fully completed, also Attach the dp that RBSliderFastList uses*/
        }
    }
    /**
     * NOTE: Basically not in refreshState
     */
    func onRefreshComplete(){
        Swift.print("🌵 CommitListable.onRefreshComplete()")
        reUseAll()/*Refresh*/
        progressIndicator.progress(0)
        progressIndicator.stop()
        _state.isInDeactivateRefreshModeState = true
        _state.hasReleasedBeyondTop = true/*⚠️️Quick temp fix*/
        moverGroup?.yMover.frame.y = 0
        moverGroup?.yMover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        //mover!.isDirectlyManipulating = false
        moverGroup?.yMover.value = moverGroup!.yMover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        moverGroup?.yMover.start()
        //progressIndicator!.reveal(0)//reset all line alphas to 0
        Swift.print("🏁🏁🏁 CommitListable AutoSync and Refresh completed \(performance.autoSyncAndRefreshStartTime.secsSinceStart)")
    }
    /**
     * This Happens when you use the scrollwheel or use the slider (also works while there still is momentum) (This content of this method could be inside setProgress, but its easier to reason with if it is its own method)
     * TODO: ⚠️️ Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func iterateProgressBar(_ value:CGFloat){//TODO: rename to iterateProgressBar
        //Swift.print("🌵 ICommitsList.iterateProgressBar(\(value))")
        //let value = mover!.result
        //Swift.print("CommitsList.onProgress() mover!.result: \(mover!.result) progressValue: \(progressValue!)  hasPulledAndReleasedBeyondRefreshSpace: \(hasPulledAndReleasedBeyondRefreshSpace) isTwoFingersTouching \(isTwoFingersTouching)")
        //Swift.print("ICommitList.iterateProgressBar value: " + "\(value)")
        if(value >  0 && value < 60){//between 0 and 60
            //Swift.print("start progressing the ProgressIndicator")
            let scalarVal:CGFloat = value / 60//0 to 1 (value settle on near 0)
            if _state.hasPulledAndReleasedBeyondRefreshThreshold {//isInRefreshMode
                progressIndicator.frame.y = -45 + (scalarVal * 60)
            }else if _state.isTwoFingersTouching || _state.hasReleasedBeyondTop {
                progressIndicator.frame.y = 15//<--this could be set else where but something kept interfering with it
                progressIndicator.reveal(scalarVal)//the progress indicator needs to be able to be able to reveal it self 1 tick at the time in the init state
            }
        }else if(value > 60){
            progressIndicator.frame.y = 15
        }
    }
    
    //TODO: ⚠️️ Move into extension ?
    
    func scrollAnimStopped(){
        Swift.print("🌵 ICommitsList.scrollAnimStopped()")
        //⚠️️ defaultScrollAnimStopped()
        //hideSlider()
        if _state.isInDeactivateRefreshModeState {
            //Swift.print("reset refreshState")
            _state.hasPulledAndReleasedBeyondRefreshThreshold = false//reset
            _state.isInDeactivateRefreshModeState = false//reset
        }
    }
}

extension CommitListable{
    /**
     * Used to start autosync externally, from an interval timer for instance.
     * PARAM: onComplete
     */
    func initiateAutoSyncMode(_ onComplete:@escaping ()->Void){
        Swift.print("initiateAutoSyncMode()")
        progressIndicator.start()/*start spinning the progressIndicator*/
        _state.hasPulledAndReleasedBeyondRefreshThreshold = true/*set the state*/
        startAutoSync({self.onRefreshComplete();onComplete()})
    }
}

