import Foundation

protocol ICommitList:IFastList2 {
    /*Related to ICommitList*/
    var isTwoFingersTouching:Bool {get set}
    var progressIndicator:ProgressIndicator? {get set}
    var hasPulledAndReleasedBeyondRefreshSpace:Bool{get set}
    var hasReleasedBeyondTop:Bool {get set}
    var autoSyncAndRefreshStartTime:NSDate? {get set}
    func startAutoSync()
}
extension ICommitList{
    
    //these are just add hock methods, you can just adhock them with the scrollWheel method, only 2 lines of code
    
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
