import Foundation
@testable import Element
@testable import Utils


//you need to research prevDelta more. you need to be accurate when determining direction. 
    //you dont want to go backwards when you just scrolled forward and stopped etc.


class SnappyRubberBand:RubberBand{
    var minVelocity:CGFloat = 0.8
    var snap:CGFloat = 100
    var prevDir:CGFloat = 0//-1,1 
    /*var dir:Int = 0
     override func start() {
     dir = velocity.isNegative ? -1 : 1
     super.start()
     }
     override func stop() {
     dir = velocity.isNegative ? -1 : 1
     super.stop()
     }*/
    /*init(_ animatable: IAnimatable, _ callBack: @escaping (CGFloat) -> Void, _ maskFrame: RubberBand.Frame, _ contentFrame: RubberBand.Frame, _ value: CGFloat, _ velocity: CGFloat, _ friction: CGFloat, _ springEasing: CGFloat, _ spring: CGFloat, _ limit: CGFloat, ) {
     self.snap = snap
     self.minVelocity = minVelocity
     super.init(animatable, callBack, maskFrame, contentFrame, value, velocity, friction, springEasing, spring, limit)
     }*/
    override func applyFriction() {
        //Swift.print("SnappyRubberBand.applyFriction() velocity: \(velocity) value: \(value)")
        if(velocity == 0){/*when scrollWheel exit and its abs(prevScrollDelta) < 3 then we set the velocity to 0*/
            Swift.print("prevDir: " + "\(prevDir)")
            if(prevDir.isPositive){/*abs(mod) <= snap/2*/
                velocity = minVelocity
                Swift.print("go backward velocity : \(velocity)")
            }else if(prevDir.isNegative) {
                Swift.print("go forward velocity : \(velocity)")
                velocity = -minVelocity
            }else{/*prevDir == 0*/
                velocity = 0
            }
        }
        value += velocity
        
        let modulo:CGFloat = (value %% snap)
        if(abs(modulo).isNear(0, minVelocity)){/*stop the value is close enough to target*/
            hasStopped = true
            stop()
            value = CGFloatModifier.roundTo(value, snap)
        }
        if(abs(velocity) <= minVelocity){/*Velocity is bellow min allowed, add velocity keep anim alive*/
            velocity = prevDir.isNegative ? -minVelocity : minVelocity
        }else{
            super.applyFriction()//regular friction
        }
    }
}

//You need to detect dist to target on stationary scrollwheel exit.
//as it doesnt have direction
//you need to add some dist to target code 👈 🏀
//try to drag and drop it into position
//you need to calculate the direction on release. why?
//you need to set the final value so that it snaps to the perfect value✅
//find the round to method and round value to snap✅

