import Cocoa

class CommitsList:RBSliderList {
    var progressIndicator:ProgressIndicator?
    override func resolveSkin() {
        super.resolveSkin()
        let piContainer = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        progressIndicator = piContainer.addSubView(ProgressIndicator(30,30,piContainer))
    }
    var isPulledBeyondRefreshSpace:Bool = false
    /**
     * Happens when you use the scrollwheel or use the slider
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    func onScroll(){
        let progressValue = self.progressValue!
        Swift.print("onScroll() progressValue: " + "\(progressValue)")
        if(progressValue < -0.1){
            Swift.print("go into refresh mode")
            isPulledBeyondRefreshSpace = true
        }else{
            if(progressValue <  0 && progressValue > -0.1){//between 0 and -1
                Swift.print("start progressing the ProgressIndicator")
                let scalarVal:CGFloat = progressValue / -0.1//0 to 1
                progressIndicator!.progress(scalarVal)
            }
            isPulledBeyondRefreshSpace = false//reset
        }
    }
    
    
    // on release of scrollGesture/sliderButton && isPulledBeyondRefreshSpace
        //start spinning the progressIndicator
    
        //
    
    
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
