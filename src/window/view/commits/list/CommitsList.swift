import Cocoa

class CommitsList:RBSliderList {
    var progressIndicator:ProgressIndicator?
    var hasPulledBeyondRefreshSpace:Bool = false
    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
        scrollController!.event = onEvent
    }
    
    /**
     * Happens when you use the scrollwheel or use the slider (also works while there is momentum)
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onScroll(){
        //Swift.print("onScroll() progressValue: " + "\(progressValue!)")
        /*
        if(scrollController!.mover.value < 50){
            //Swift.print("go into refresh mode")
            isPulledBeyondRefreshSpace = true
        }else{
            isPulledBeyondRefreshSpace = false//reset
        }
        */
        let value = scrollController!.mover.result
        if(value >  0 && value < 60){//between 0 and 50
            //Swift.print("start progressing the ProgressIndicator")
            let scalarVal:CGFloat = value / 60//0 to 1
            
            //isInRefreshMode
            progressIndicator!.progress(scalarVal)
            
            //Continue here: use the result value not the value. as the surface slips
            
            progressIndicator!.frame.y = -45 + (scalarVal * 60)
        }else if(value > 60){
            hasPulledBeyondRefreshSpace = true
        }
    }
    
    //Continue here: onScrollWheleDown -> set topMargin to 0
        //implement event for scrollWheelDown
        //then remove topMargin, and begin working with frame.y
        //also you want the apple mail ProgressIndicator behaviour with a more of a revealing transition 
        //when you are in the refresh mode and want to continue scrolling
            //then you move the ProgressIndicator out of the way
                //infact you should add this behaviour to the revealing aswell
    
    func scrollWheelExit(){
        Swift.print("CommitList.scrollWheelExit()")
        let value = scrollController!.mover.result
        if(value > 60){
            Swift.print("start animation the ProgressIndicator")
            scrollController!.mover.frame.y = 60
            
            //start spinning the progressIndicator
            
            //spring to refreshStatePosition
            
            //figure out how to set a new springTo target (requires some thinking)
        }else{
            //scrollController!.mover.topMargin = 0
        }
    }
    
    //Continue here: Actually you need to implement topMargin in the non-boundry area aswell. 
        //since when you scroll in refresh mode the refresh area need to become visible if it comes in to focus during the scrolling session
    
    func scrollWheelEnter(){
        Swift.print("CommitList.scrollWheelEnter()" + "\(progressValue)")
    }
    //on release of scrollGesture/sliderButton && isPulledBeyondRefreshSpace
    override func onEvent(event: Event) {
        if(event.assert(ScrollWheelEvent.exit, scrollController)){
            scrollWheelExit()
        }else if(event.assert(ScrollWheelEvent.enter, scrollController)){
            scrollWheelEnter()
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
