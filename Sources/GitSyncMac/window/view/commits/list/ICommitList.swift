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
