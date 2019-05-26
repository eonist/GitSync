import Cocoa
@testable import Utils
@testable import Element


class CommitListHandler:ElasticSliderScrollerFastListHandler,CommitListable2Decorator {
    /**
     * this makes the scrolling go in only the y-axis
     */
    override func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        moverGroup.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup.result
//        setProgressVal(p.x,.hor)
        setProgressVal(p.y,.ver)
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        setProgress(progressVal)
    }
    /**
     * MoverGroup calls this method
     */
    func setProgressValue(_ value:CGFloat, _ dir:Dir){/*gets called from MoverGroup*/
//        Swift.print("CommitListHandler.setProgressValue")
        guard dir == .ver else {return}//this makes the scrolling go in only the y-axis
        if dir == .ver && _state.hasReleasedBeyondTop{
            //Swift.print("🌵 ICommitList.setProgressValue : hasReleasedBeyondTop: \(hasReleasedBeyondTop)")
            iterateProgressBar(value)
        }
        (progressable as! CommitList2).setProgressValue(value,dir)
        
    }
    /**
     * TODO: ⚠️️ Comment this method, it can probably removed because swift 4 has more "where extension" support
     */
    override func scroll(_ event:NSEvent) {
//        Swift.print("CommitListHandler.scroll()")
        super.scroll(event)
        
        //⚠️️ I think its safe to override onChange? ⚠️️
        if event.phase == NSEvent.Phase.changed {//this is only direct manipulation, not momentum
            iterateProgressBar(moverGroup.result.y)/*mover!.result*/
        }else if event.phase == NSEvent.Phase.mayBegin || event.phase == NSEvent.Phase.began {
            scrollWheelEnter()
        }else if event.phase == NSEvent.Phase.ended || event.phase == NSEvent.Phase.cancelled {
            scrollWheelExit()
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
        let value = moverGroup.result.y
        if value > 60{
            //Swift.print("start animation the ProgressIndicator")
            moverGroup.yMover.frame.y = 60
            progressIndicator.start()//1. start spinning the progressIndicator
            _state.hasPulledAndReleasedBeyondRefreshThreshold = true
            initSync(isUserInitiated: true,completed: self.onRefreshComplete)/*🚪⬅️️ <- starts the process of downloading commits here*/
        }else if value > 0{
            _state.hasReleasedBeyondTop = true
            //scrollController!.mover.topMargin = 0
        }else{
            _state.hasReleasedBeyondTop = false
        }/**/
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
        if value >  0 && value < 60 {//between 0 and 60
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
        Swift.print("scrollAnimStopped()")
        //⚠️️ defaultScrollAnimStopped()
        //hideSlider()
        if _state.isInDeactivateRefreshModeState {
            //Swift.print("reset refreshState")
            _state.hasPulledAndReleasedBeyondRefreshThreshold = false//reset
            _state.isInDeactivateRefreshModeState = false//reset
        }
    }
}
