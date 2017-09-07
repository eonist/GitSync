import Cocoa
@testable import Utils
@testable import Element

/**
 * Related to the AutoSync and Refresh processes
 */
extension CommitListHandler{
    /**
     * Starts the auto sync process (Happens after the pull to refresh gesture)
     * PARAM: completed: when AutoSync and Refresh are completed this closure is called
     */
    func initSync(isUserInitiated:Bool, completed:@escaping ()->Void){
        Swift.print("initSync")
        performance.autoSyncAndRefreshStartTime = Date()//init debug timer, TODO: move this inside startAutoSync method, maybe?
        performance.autoSyncStartTime = Date()/*Sets debug timer*/
        _ = AutoSync.init(isUserInitiated: isUserInitiated){ (repoList:[RepoItem]) in/*⬅️️🚪 Start the refresh process when AutoSync.onComplete is fired off*/
            Swift.print("🏁🏁🏁 AutoSyncCompleted" + "\(self.performance.autoSyncStartTime.secsSinceStart)")/*How long did the gathering of git commit logs take?*/
            _ = Refresh(dp:self.dp as! CommitDP, repoList:repoList ,onComplete:completed)/* ⬅️️ Refresh happens after AutoSync is fully completed, also Attach the dp that RBSliderFastList uses*/
        }
    }
    /**
     * NOTE: Basically refreshState has ended
     */
    func onRefreshComplete(){
        Swift.print("🌵 CommitListable.onRefreshComplete()")
        reUseAll()/*Refresh*/
        progressIndicator.progress(0)
        progressIndicator.stop()
        _state.isInDeactivateRefreshModeState = true
        _state.hasReleasedBeyondTop = true/*⚠️️Quick temp fix*/
        moverGroup.yMover.frame.y = 0
        moverGroup.yMover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        //mover!.isDirectlyManipulating = false
        moverGroup.yMover.value = moverGroup.yMover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        moverGroup.yMover.start()
        //progressIndicator!.reveal(0)//reset all line alphas to 0
        Swift.print("🏁🏁🏁 CommitListable AutoSync and Refresh completed \(performance.autoSyncAndRefreshStartTime.secsSinceStart)")
    }
}
/**
 * External Ad-hock methods
 */
extension CommitListHandler{
    /**
     * Used to start autosync externally, from an interval timer for instance. (A sort of ad-hock method)
     * PARAM: onComplete: called when the autoSync process completes
     */
    func initSyncFromInterval(_ onComplete:@escaping ()->Void){
        Swift.print("initiateAutoSyncMode()")
        progressIndicator.start()/*start spinning the progressIndicator*/
        _state.hasPulledAndReleasedBeyondRefreshThreshold = true/*set the state*/
        initSync(isUserInitiated: false,completed: {self.onRefreshComplete();onComplete()})
    }
}
