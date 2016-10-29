import Cocoa

//Continue here: only reveal the progressindicator if you are touching the touchpad

class CommitsList:RBSliderList {
    var progressIndicator:ProgressIndicator?
    var hasPulledAndReleasedBeyondRefreshSpace:Bool = false
    var isInDeactivateRefreshModeState:Bool = false
    var isTwoFingersTouching = false//is Two Fingers Touching the Touch-Pad
    var hasReleasedBeyondTop:Bool = false
    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
        progressIndicator!.frame.y = -45//hide at init
        progressIndicator!.animator!.event = onEvent
    }
    /**
     * Happens when you use the scrollwheel or use the slider (also works while there still is momentum)
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onScroll(){
        //Swift.print("CommitsList.onScroll() progressValue: " + "\(progressValue!)" + " hasPulledAndReleasedBeyondRefreshSpace: \(hasPulledAndReleasedBeyondRefreshSpace)")
        let value = scrollController!.mover.result
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
    /**
     * Basically not in refreshState
     */
    func loopAnimationCompleted(){
        //Swift.print("CommitList.loopAnimationCompleted()")
        isInDeactivateRefreshModeState = true
        scrollController!.mover.frame.y = 0
        scrollController!.mover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        scrollController!.mover.isDirectlyManipulating = false
        scrollController!.mover.value = scrollController!.mover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        scrollController!.mover.start()
        //progressIndicator!.reveal(0)//reset all line alphas to 0
    }
    
    override func scrollWheelEnter() {
        isTwoFingersTouching = true
        super.scrollWheelEnter()
    }
    
    override func scrollWheelExit(){
        isTwoFingersTouching = false
        //Swift.print("CommitList.scrollWheelExit()")
        let value = scrollController!.mover.result
        if(value > 60){
            //Swift.print("start animation the ProgressIndicator")
            scrollController!.mover.frame.y = 60
            progressIndicator!.start()//1. start spinning the progressIndicator
            hasPulledAndReleasedBeyondRefreshSpace = true
            
        }else if (value > 0){
            hasReleasedBeyondTop = true
            //scrollController!.mover.topMargin = 0
        }else{
            hasReleasedBeyondTop = false
        }
    }
    func scrollAnimStopped(){
        //Swift.print("CommitsList.scrollAnimStopped()")
        slider!.thumb!.fadeOut()
        if(isInDeactivateRefreshModeState){
            //Swift.print("reset refreshState")
            hasPulledAndReleasedBeyondRefreshSpace = false//reset
            isInDeactivateRefreshModeState = false//reset
        }
    }
    override func onEvent(event:Event) {
        //Swift.print("CommitsList.onEvent() event.type: " + "\(event.type)")
        if(event.assert(AnimEvent.completed, progressIndicator!.animator)){
            loopAnimationCompleted()
        }else if(event.assert(AnimEvent.stopped, scrollController!.mover)){
            scrollAnimStopped()
        }
        super.onEvent(event)
    }
    override func setProgress(value:CGFloat) {
        super.setProgress(value)
        onScroll()
    }
    /**
     * NOTE: this method overrides the mergeAt method to facilitate special list items
     */
    override func mergeAt(objects: [Dictionary<String, String>], _ index: Int) {
        var i:Int = index
        //Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            let item:CommitsListItem = CommitsListItem(width, itemHeight ,object["repo-name"]!, object["contributor"]!,object["title"]!,object["description"]!,object["date"]!, false, self.lableContainer)
            lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
    override func getClassType() -> String {
        return String(List)
    }
}