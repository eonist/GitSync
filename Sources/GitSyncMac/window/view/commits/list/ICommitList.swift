import Cocoa
@testable import Utils
@testable import Element

protocol ICommitList:ElasticSlidableScrollableFast {
    /*Related to ICommitList*/
    var isTwoFingersTouching:Bool {get set}
    var progressIndicator:ProgressIndicator? {get set}
    var isInDeactivateRefreshModeState:Bool {get set}/*is Two Fingers Touching the Touch-Pad*/
    var hasPulledAndReleasedBeyondRefreshSpace:Bool{get set}
    var hasReleasedBeyondTop:Bool {get set}
    func startAutoSync()
    /*Debug*/
    var autoSyncAndRefreshStartTime:NSDate? {get set}
    var autoSyncStartTime:NSDate? {get set}
}
extension ICommitList{
    func setProgress(_ value:CGFloat) {
        Swift.print("🌵 ICommitList.setProgress : hasReleasedBeyondTop: \(hasReleasedBeyondTop)")
        if(hasReleasedBeyondTop){
            iterateProgressBar(value)
        }
        (self as ElasticSlidableScrollableFast).setProgress(value)
     }
    
    //Continue here: 
        //you need setProgress calls from mover.setProgress, so you probably need to install mover in CommitList
    
    func scroll(_ event:NSEvent) {
        Swift.print("🌵 ICommitList.scroll()")
        (self as ElasticSlidableScrollableFast).scroll(event)//👈 calls from shallow can overide downstream
        if(event.phase == NSEventPhase.changed){//this is only direct manipulation, not momentum
            iterateProgressBar(mover!.result)
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            (self as ICommitList).scrollWheelEnter()
        }else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
            (self as ICommitList).scrollWheelExit()
        }
    }
    //these are just add hock methods, you can just adhock them with the scrollWheel method, only 2 lines of code
    
    func scrollWheelEnter() {
        Swift.print("🌵 ICommitsList.scrollWheelEnter")
        reUseAll()/*Refresh*/
        isTwoFingersTouching = true
        //⚠️️ defaultScrollWheelEnter()
    }
    func scrollWheelExit(){
        Swift.print("🌵 CommitList.scrollWheelExit()")
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
    /**
     * Starts the auto sync process
     */
    func startAutoSync(){
        Swift.print("🌵 ICommitList.startAutoSync")
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
        Swift.print("🌵 ICommitList.loopAnimationCompleted()")
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
    func iterateProgressBar(_ value:CGFloat){//TODO: rename to iterateProgressBar
        Swift.print("🌵 ICommitsList.onProgress()")
        //let value = mover!.result
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
    
    //TODO:move into extension
    
    func scrollAnimStopped(){
        Swift.print("🌵 ICommitsList.scrollAnimStopped()")
        //⚠️️ defaultScrollAnimStopped()
        hideSlider()
        if(isInDeactivateRefreshModeState){
            //Swift.print("reset refreshState")
            hasPulledAndReleasedBeyondRefreshSpace = false//reset
            isInDeactivateRefreshModeState = false//reset
        }
    }
}

