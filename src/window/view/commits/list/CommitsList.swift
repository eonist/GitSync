import Cocoa

class CommitsList:RBSliderList {
    var progressIndicator:ProgressIndicator?
    var hasPulledAndReleasedBeyondRefreshSpace:Bool = false
    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
        scrollController!.event = onEvent
        progressIndicator!.frame.y = 15
        progressIndicator!.animator!.event = onEvent
    }
    /**
     * Happens when you use the scrollwheel or use the slider (also works while there still is momentum)
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onScroll(){
        //Swift.print("onScroll() progressValue: " + "\(progressValue!)")
        let value = scrollController!.mover.result
        if(value >  0 && value < 60){//between 0 and 50
            //Swift.print("start progressing the ProgressIndicator")
            let scalarVal:CGFloat = value / 60//0 to 1
            if(hasPulledAndReleasedBeyondRefreshSpace){//isInRefreshMode
                progressIndicator!.frame.y = -45 + (scalarVal * 60)
            }else{
                progressIndicator!.reveal(scalarVal)//the progress indicator needs to be able to be able to reveal it self 1 tick at the time in the init state
            }
        }else if(value > 60){
            progressIndicator!.frame.y = 15
        }
    }
    /**
     *
     */
    func loopAnimationCompleted(){
        Swift.print("CommitList.loopAnimationCompleted()")
        scrollController!.mover.frame.y = 0
        scrollController!.mover.hasStopped = false/*reset this value to false, so that the FrameAnimatior can start again*/
        scrollController!.mover.isDirectlyManipulating = false
        scrollController!.mover.value = scrollController!.mover.result/*copy this back in again, as we used relative friction when above or bellow constraints*/
        scrollController!.mover.start()
        hasPulledAndReleasedBeyondRefreshSpace = false//reset
    }
    
    
    func scrollWheelExit(){
        Swift.print("CommitList.scrollWheelExit()")
        let value = scrollController!.mover.result
        if(value > 60){
            Swift.print("start animation the ProgressIndicator")
            scrollController!.mover.frame.y = 60
            progressIndicator!.start()//1. start spinning the progressIndicator
            hasPulledAndReleasedBeyondRefreshSpace = true
            
        }else{
            //scrollController!.mover.topMargin = 0
        }
    }
    func scrollWheelEnter(){//2. spring to refreshStatePosition
        Swift.print("CommitList.scrollWheelEnter()" + "\(progressValue)")
    }
    override func onEvent(event: Event) {
        if(event.assert(ScrollWheelEvent.exit, scrollController)){
            scrollWheelExit()
        }else if(event.assert(ScrollWheelEvent.enter, scrollController)){
            scrollWheelEnter()
        }else if(event.assert(AnimEvent.completed, progressIndicator!.animator)){
            loopAnimationCompleted()
        }else if(event.assert(AnimEvent.completed, scrollController!.mover)){
            
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

//repo-name
//contributor
//title
//description
//date
