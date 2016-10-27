import Cocoa

class CommitsList:RBSliderList {
    var progressIndicator:ProgressIndicator?
    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
        scrollController!.event = onEvent
    }
    var isPulledBeyondRefreshSpace:Bool = false
    /**
     * Happens when you use the scrollwheel or use the slider
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onScroll(){
        //Swift.print("onScroll() progressValue: " + "\(progressValue!)")
        if(progressValue! < -0.1){
            //Swift.print("go into refresh mode")
            isPulledBeyondRefreshSpace = true
        }else{
            if(progressValue! <  0 && progressValue > -0.1){//between 0 and -1
                //Swift.print("start progressing the ProgressIndicator")
                let scalarVal:CGFloat = progressValue! / -0.1//0 to 1
                progressIndicator!.progress(scalarVal)
            }
            isPulledBeyondRefreshSpace = false//reset
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
        Swift.print("CommitList.scrollWheelExit()" + "\(progressValue)")
        if(progressValue! < -0.1){
            Swift.print("start animation the ProgressIndicator")
            scrollController!.mover.topMargin = 50
            
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
