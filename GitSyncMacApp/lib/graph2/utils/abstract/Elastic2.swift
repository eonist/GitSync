import Foundation

protocol Elastic2 {
    var mover:RubberBand?{get set}
    var prevScrollingDeltaY:CGFloat{get set}
    var velocities:[CGFloat]{get set}
    //⚠️️ you may be able to remove progressvalue in the future. as it works differently now!=!=?
    var progressValue:CGFloat?{get set}//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    var iterimScroll:InterimScroll{get set}
}
