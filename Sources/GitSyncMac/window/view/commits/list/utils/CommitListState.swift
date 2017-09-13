import Foundation

struct CommitListState{
    var isTwoFingersTouching:Bool = false
    var isInDeactivateRefreshModeState:Bool = false /*is Two Fingers Touching the Touch-Pad*/
    var hasPulledAndReleasedBeyondRefreshThreshold:Bool = false/*Is now in "AutoSync" mode*/
    var hasReleasedBeyondTop:Bool = false
    var isReadyToSync:Bool {return !self.hasPulledAndReleasedBeyondRefreshThreshold && !isInDeactivateRefreshModeState && !isTwoFingersTouching}
}

