import Foundation

struct CommitListState{
    var isTwoFingersTouching:Bool = false
    var isInDeactivateRefreshModeState:Bool = false /*is Two Fingers Touching the Touch-Pad*/
    var hasPulledAndReleasedBeyondRefreshSpace:Bool = false
    var hasReleasedBeyondTop:Bool = false
}
