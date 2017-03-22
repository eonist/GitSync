import Foundation
@testable import Element
@testable import Utils

class SnappyRubberBand:RubberBand{
    var minVelocity:CGFloat = 0.8
    var snap:CGFloat = 100
    /*init(_ animatable: IAnimatable, _ callBack: @escaping (CGFloat) -> Void, _ maskFrame: RubberBand.Frame, _ contentFrame: RubberBand.Frame, _ value: CGFloat, _ velocity: CGFloat, _ friction: CGFloat, _ springEasing: CGFloat, _ spring: CGFloat, _ limit: CGFloat, ) {
     self.snap = snap
     self.minVelocity = minVelocity
     super.init(animatable, callBack, maskFrame, contentFrame, value, velocity, friction, springEasing, spring, limit)
     }*/
    override func applyFriction() {
        Swift.print("SnappyRubberBand.applyFriction() velocity: \(velocity) value: \(value)")
        //keep some velocity alive
        //when at snap stop
        if(abs(velocity) <= minVelocity){
            let modulo:CGFloat = (value %% snap)
            Swift.print("modulo: " + "\(modulo)")
            if(abs(modulo).isNear(0, minVelocity)){//modulo is closer than 1 px to 0,
                hasStopped = true
                stop()
                
                //you need to add some dist to target code 🏀
                //try to drag and drop it into position
                //you need to calculate the direction on release.👈
                //you need to set the final value so that it snaps to the perfect value
                //find the round to method and round value to snap
                value = CGFloatModifier.roundTo(value, snap)
            }else{
                velocity = velocity.isNegative ? -minVelocity : minVelocity
                value += velocity
            }
            
        }else{
            super.applyFriction()//regular friction
        }
        super.applyFriction()
    }
}
