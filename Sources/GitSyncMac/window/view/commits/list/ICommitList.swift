import Foundation

protocol ICommitList: DEPRECATEDIRBSlidable {
    var isTwoFingersTouching:Bool {get set}
    var progressIndicator:ProgressIndicator? {get set}
    var hasPulledAndReleasedBeyondRefreshSpace:Bool{get set}
    var hasReleasedBeyondTop:Bool {get set}
    var autoSyncAndRefreshStartTime:NSDate? {get set}
    func startAutoSync()
    /*fast list related*/
    func reUseAll()
    func reUse(_ listItem:FastListItem)
}
